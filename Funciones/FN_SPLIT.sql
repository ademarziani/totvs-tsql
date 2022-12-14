CREATE OR ALTER FUNCTION dbo.FN_SPLIT( @STRING VARCHAR(4000), @SEP VARCHAR(1))
RETURNS
	@RESULT TABLE (VALOR VARCHAR(100))
AS
BEGIN
    DECLARE @LEN INT, @LOC INT = 1
    WHILE @LOC <= LEN(@STRING) 
    BEGIN
        SET @LEN = CHARINDEX(@SEP, @STRING, @LOC) - @LOC
        IF @LEN < 0 SET @LEN = LEN(@STRING)
        INSERT INTO @RESULT VALUES (SUBSTRING(@STRING,@LOC,@LEN))
        SET @LOC = @LOC + @LEN + 1
    END
    RETURN
END

