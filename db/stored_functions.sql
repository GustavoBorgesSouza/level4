-- just like a stored procedure, but MUST return a value

-- SYNTAX
-- CREATE [ OR REPLACE] FUNCTION nome_função
-- [(parâmetro [in] tipo_parâmetro,
--   ...
-- return tipo_do_retorno

-- {IS ou AS}

-- BEGIN
--    corpo_da_função
-- END nome_função;


-- EXAMPLE

CREATE OR REPLACE FUNCTION descobrir_salario (
    p_id   IN emp.empno%TYPE
) RETURN NUMBER IS v_salario   emp.sal%TYPE := 0;
BEGIN
    SELECT  sal
    INTO    v_salario
        FROM    emp
    WHERE   empno = p_id;

    RETURN v_salario;  
END descobrir_salario;
/

SELECT empno, descobrir_salario(empno)
FROM   emp;

-- single use
SET SERVEROUTPUT ON
BEGIN
    dbms_output.put_line(descobrir_salario(7782) );
END;
/

-- NO PARAMS
CREATE OR REPLACE FUNCTION contadept RETURN NUMBER IS
    total   NUMBER(7) := 0;
BEGIN
    SELECT COUNT(*)
    INTO   total
    FROM   dept;

    RETURN total;
END;
/

SET SERVEROUTPUT ON

DECLARE
    conta   NUMBER(7);
BEGIN
    conta := contadept ();
    dbms_output.put_line
    ('Quantidade de Departamentos: ' || conta);
END;
/

-- MORE EXAMPLES
CREATE OR REPLACE FUNCTION sal_anual (
    p_sal NUMBER,
    p_comm NUMBER
) RETURN NUMBER 
IS
BEGIN
   RETURN ( p_sal + nvl(p_comm,0) ) * 12;
END sal_anual;
/

SELECT sal, comm, sal_anual(sal, comm)
FROM emp;

SET SERVEROUTPUT ON

DECLARE
    total   NUMBER(7);
BEGIN
    total := sal_anual(900,100);
    dbms_output.put_line('Salario anual: ' || total);
END;
/

-- 
CREATE OR REPLACE FUNCTION ordinal (
    p_numero NUMBER
) RETURN VARCHAR2
IS
BEGIN
    CASE
        p_numero
        WHEN 1 THEN
            RETURN 'primeiro';
        WHEN 2 THEN
            RETURN 'segundo';
        WHEN 3 THEN
            RETURN 'terceiro';
        WHEN 4 THEN
            RETURN 'quarto';
        WHEN 5 THEN
            RETURN 'quinto';
        WHEN 6 THEN
                RETURN 'sexto';
        WHEN 7 THEN
            RETURN 'sétimo';
        WHEN 8 THEN
            RETURN 'oitavo';
        WHEN 9 THEN
            RETURN 'nono';
        ELSE
            RETURN 'não previsto';
    END CASE;
END ordinal;
/

SELECT ORDINAL(9)
FROM dual;

SET SERVEROUTPUT ON

BEGIN
    FOR i IN 1..9 LOOP
        dbms_output.put_line(ordinal(i) );
    END LOOP;
END;
/

