--1
CREATE PROCEDURE GetBalanceByCardNum
    @cardNum VARCHAR(20)
AS
BEGIN
    SELECT balance
    FROM Card
    WHERE cardNum = @cardNum

END
--2
CREATE PROCEDURE GetUserDetailsByUserId
    @userId INT
AS
BEGIN
    SELECT *
    FROM User
    WHERE userId = @userId

END

GO
GO
--3
CREATE PROCEDURE GetUserDetailsByName
    @userName VARCHAR(20)
AS
BEGIN
    SELECT *
    FROM User
    WHERE name = @userName

END
GO
--4
CREATE PROCEDURE GetCardNumsAndBalancesByUserId
    @userId INT
AS
BEGIN
    SELECT C.cardNum, C.balance
    FROM User U
    JOIN UserCard UC ON U.userId = UC.userId
    JOIN Card C ON UC.cardNum = C.cardNum
    WHERE U.userId = @userId
END

GO

--5
CREATE PROCEDURE Login
    @cardNum VARCHAR(20),
    @PIN VARCHAR(4),
    @status BIT OUTPUT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Card WHERE cardNum = @cardNum AND PIN = @PIN)
    BEGIN
        SET @status = 1
    END
    ELSE
    BEGIN
        SET @status = 0
 
   END
END
GO

EXEC GetBalanceByCardNum @cardNum = '1234'
EXEC GetUserDetailsByUserId @userId = 1
EXEC GetUserDetailsByName @userName = 'Ali'
EXEC GetCardNumsAndBalancesByUserId @userId = 2
EXEC Login @cardNum = '1234', @PIN = '1770', @status = @outStatus OUTPUT
SELECT @outStatus

--6--CREATE PROCEDURE GetNumberOfCardsByUserId

  @userId INT,

  @numCards INT OUTPUT

AS

BEGIN

  SELECT COUNT(*) AS numCards

  FROM UserCard

  WHERE userId = @userId



  SET @numCards = ISNULL(@numCards, 0); -- Set numCards to 0 if no cards found

END;

GO



--7



CREATE PROCEDURE UpdatePIN

  @cardNum VARCHAR(20),

  @oldPIN VARCHAR(4),

  @newPIN VARCHAR(4)

AS

BEGIN

  DECLARE @rowsAffected INT;



  UPDATE Card

  SET PIN = @newPIN

  WHERE cardNum = @cardNum AND PIN = @oldPIN;



  SET @rowsAffected = @@ROWCOUNT;



  IF @rowsAffected > 0

  BEGIN

    PRINT 'PIN is Updated';

  ELSE

  BEGIN

    PRINT 'Error: PIN update failed.';

  END

END;

GO

--8

CREATE PROCEDURE Withdraw

  @cardNum VARCHAR(20),

  @PIN VARCHAR(4),

  @amount DECIMAL(10,2),

  @transType INT OUTPUT

AS

BEGIN

  DECLARE @balance DECIMAL(10,2), @newBalance DECIMAL(10,2);



  BEGIN TRANSACTION;

  -- Login check (call Login procedure)

  EXEC Login @cardNum, @PIN, @transType OUTPUT;

  IF @transType = 1 -- Login successful

  BEGIN

    SELECT @balance = balance FROM Card WHERE cardNum = @cardNum;

    IF @balance >= @amount -- Sufficient balance

    BEGIN

      UPDATE Card SET balance = balance - @amount WHERE cardNum = @cardNum;

      SET @newBalance = balance - @amount;

      -- Insert transaction (successful)

      INSERT INTO Transaction (transId, transDate, cardNum, amount, transType)

      VALUES ((SELECT ISNULL(MAX(transId), 0) + 1 FROM Transaction), GETDATE(), @cardNum, @amount, 1);

      SET @transType = 1; -- Set successful transaction type

      COMMIT TRANSACTION;

      PRINT 'Transaction Successful. New Balance: ' + CAST(@newBalance AS VARCHAR(10));

    END

    ELSE -- Insufficient balance

    BEGIN

      SET @transType = 3; -- Set insufficient balance type

      ROLLBACK TRANSACTION;

      PRINT 'Insufficient Funds.';

    END

  END

  ELSE -- Login failed

  BEGIN

    SET @transType = 4; -- Set failed transaction type

    ROLLBACK TRANSACTION;

    PRINT 'PIN verification failed.';

  END

END;

GO

