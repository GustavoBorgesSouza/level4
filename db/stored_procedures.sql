
-- Syntax:

-- CREATE [ OR REPLACE] nome_procedimento
-- [parâmetro [{in, out, in out}] tipo_parâmetro,
--   ...
-- {IS ou AS}

-- BEGIN
-- corpo_do_procedimento
		
-- END [nome_procedimento];

-- Exemplo:
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE quadrado
(p_num IN NUMBER :=0)
IS
BEGIN
DBMS_OUTPUT.PUT_LINE (p_num*p_num );
END quadrado;
/

EXECUTE quadrado(8);


-- PARAMETERS

-- ENTRADA

CREATE OR REPLACE PROCEDURE reajuste (
    v_codigo_emp IN emp.EMPNO%TYPE,
    v_porcentagem IN NUMBER DEFAULT 25
)
IS
BEGIN
UPDATE EMP
    SET SAL = SAL + (SAL * (v_porcentagem / 100))
WHERE EMPNO = v_codigo_emp;
    COMMIT;
END reajuste;
/

SELECT EMPNO, SAL
    FROM EMP
WHERE EMPNO = 7839; 

EXECUTE reajuste(7839, 10);

SELECT EMPNO, SAL
    FROM EMP
WHERE EMPNO = 7839; 

EXECUTE reajuste(7839);

SELECT EMPNO, SAL
    FROM EMP
WHERE EMPNO = 7839; 

-- SAIDA

CREATE OR REPLACE PROCEDURE consulta_emp
(
    p_id IN emp.EMPNO%TYPE,
    p_nome OUT emp.ENAME%TYPE,
    p_salario OUT emp.SAL%TYPE
)
IS
BEGIN 
    SELECT ENAME, SAL INTO p_nome, p_salario
    FROM EMP 
    WHERE EMPNO = p_id;
END consulta_emp;
/

SET SERVEROUTPUT ON

DECLARE
    v_nome emp.ENAME%type;
    v_salario emp.SAL%type;
BEGIN
    consulta_emp(7839, v_nome, v_salario);
    DBMS_OUTPUT.PUT_LINE(v_nome);
    DBMS_OUTPUT.PUT_LINE(v_salario);
END;
/


-- UTILIZANDO PARAMETTROS
CREATE OR REPLACE PROCEDURE formata_fone
(p_fone IN OUT VARCHAR2)
IS
BEGIN
    p_fone := '(' || SUBSTR(p_fone, 1, 3) || ')' || 
SUBSTR(p_fone, 4, 4) || '-' || SUBSTR(p_fone, 8);
END formata_fone;
/

SET SERVEROUTPUT ON

DECLARE
    v_fone VARCHAR2(30) := '01138858010';
BEGIN
    formata_fone(v_fone);
    DBMS_OUTPUT.PUT_LINE(v_fone);
END;
/

-- SHOW ERRORS

SHOW ERRORS

CREATE OR REPLACE PROCEDURE errotst AS
    v_conta NUMBER;
BEGIN
    v_conta := 7
    -- MISSING ; ABOVE
END errotst;
/


SELECT line, position, text
FROM user_errors
WHERE name = 'ERROTST'
ORDER BY sequence;

-- 
-- 
-- PASSING PARAMETERS

CREATE OR REPLACE PROCEDURE incluir_dept(
    p_cod  IN dept.deptno%TYPE DEFAULT '50',
    p_nome IN dept.dname%TYPE DEFAULT 'FIAP',
    p_loc  IN dept.loc%TYPE DEFAULT 'SP'
)
IS
BEGIN
    INSERT INTO dept(deptno, dname, loc)
    VALUES(p_cod, p_nome, p_loc);
END incluir_dept;
/

--  use default values
BEGIN
    incluir_dept;
END;
/

-- positional params
BEGIN
    incluir_dept (55, 'Onze', 'SC');
END;
/

-- named paarams
BEGIN
    incluir_dept (p_cod => 60, p_nome => 'Doze', p_loc => 'RJ');
END;
/

-- mixed params, positional, named and default
BEGIN
    incluir_dept (65, p_nome => 'Treze');
END;
/