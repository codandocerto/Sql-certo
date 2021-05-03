/*PARA SQL SERVER*/

create TRIGGER [DBO].[trig_tabela] ON [DBO].[TABELA]/*<<NOME DA TABELA*/
FOR UPDATE, DELETE AS 
BEGIN 

    DECLARE 
        @Linhas_Alteradas INT = @@ROWCOUNT,
        @Linhas_Tabela INT = (SELECT SUM(row_count) FROM sys.dm_db_partition_stats WHERE [object_id] = OBJECT_ID('TABELA')/*<<NOME DA TABELA*/ AND (index_id <= 1))

    IF (@Linhas_Alteradas >= @Linhas_Tabela)
    BEGIN 
        ROLLBACK TRANSACTION; 
        RAISERROR ('Operações de DELETE e/ou UPDATE sem cláusula WHERE não são permitidas na tabela "NOME DA TABELA"', 15, 1); 
        RETURN;
    END

END
