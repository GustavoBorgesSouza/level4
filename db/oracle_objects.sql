-- DICIONÁRIO DE
-- DADOS

-- De acordo com a Oracle (2016), o dicionário de dados é um conjunto de tabelas que armazenam infor-
-- mações (METADADOS) sobre um banco de dados. O dicionário de dados fornece uma descrição do banco
-- de dados. Nele, temos informações sobre a sua estrutura física, sua estrutura lógica e seu conteúdo. O di-
-- cionário de dados é criado durante o processo de criação do banco de dados e consiste em uma série de
-- tabelas e views.

-- O dicionário de dados contém informações sobre os objetos do banco de dados, como, por exemplo, ta-
-- belas, sinônimos, índices e restrições. Normalmente, o usuário só pode ler as informações dentro do dici-
-- onário de dados. Qualquer manutenção ao dicionário de dados é feita automaticamente pelo servidor
-- Oracle.


SELECT DISTINCT object_type 
    FROM user_objects;

SELECT DISTINCT object_type 
    FROM all_objects;


SELECT object_name
    FROM user_objects
    WHERE object_type = 'TABLE'
ORDER BY object_name
/

SELECT object_type, object_name
    FROM user_objects
    WHERE status = 'INVALID'
ORDER BY object_type, object_name
/


SELECT  object_type, object_name, 
        last_ddl_time
    FROM user_objects
    WHERE last_ddl_time >= TRUNC (SYSDATE)
ORDER BY object_type, object_name
/

-- codigo fopnte

SELECT name, line, text
    FROM user_source
    WHERE UPPER (text) 
    LIKE '%DEPT%'
ORDER BY name, line
/

-- procedures and funtions 

SELECT   object_name, procedure_name,authid
FROM     user_procedures
ORDER BY object_name, procedure_name
/

-- triggers

SELECT *
    FROM user_triggers 
WHERE status = 'DISABLED'
/

SELECT *
    FROM user_triggers 
    WHERE table_name = 'EMP'
    AND trigger_type LIKE '%EACH ROW'
/

SELECT *
    FROM user_triggers 
WHERE triggering_event LIKE '%UPDATE%'
/