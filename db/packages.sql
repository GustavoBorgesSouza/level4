-- Pacotes são áreas de armazenamento de procedimentos ou PROCEDURES, funções ou FUNCTIONS,
-- constantes, variáveis e cursores em PL/SQL que, dependendo do modo de construção, permitirão
-- compartilhar as informações deste PACKAGE com outros aplicativos. Como regra geral, as chama-
-- das aos pacotes devem fazer referência a procedimentos ou funções.

-- SYNTAX
-- CREATE [ OR REPLACE ] PACKAGE nome_pacote
-- {IS ou AS}

-- [ variáveis ]

-- [ especificação dos cursores ]

-- [ especificação dos módulos ]

-- END [nome_pacote ];

-- PACKAGE SPECIFICATION

CREATE OR REPLACE PACKAGE faculdade AS
cnome CONSTANT VARCHAR2(4) := 'FIAP';
cfone CONSTANT VARCHAR2(13) := '(11)3385-8010';
cnota CONSTANT NUMBER(2) := 10;
END faculdade;
/

--  using the package specificatons
SET SERVEROUTPUT ON

DECLARE
    melhor VARCHAR2(30);
BEGIN
    melhor := faculdade.cnome || ', a melhor faculdade';
    dbms_output.put_line(melhor);
END;
/

SET SERVEROUTPUT ON

DECLARE
    conta NUMBER(6);
BEGIN
    conta := faculdade.cnota ** 2;
    dbms_output.put_line(conta);
END;
/

-- more specification (with procedures and fucntions)
CREATE OR REPLACE PACKAGE rh AS
    FUNCTION descobrir_salario (
        p_id   IN emp.empno%TYPE
    ) RETURN NUMBER;

    PROCEDURE reajuste (
        v_codigo_emp    IN emp.empno%TYPE,
        v_porcentagem   IN NUMBER DEFAULT 25
    );

END rh;
/   

desc rh;


-- PACKAGE BODY SUNTAX
-- CREATE [ OR REPLACE ] PACKAGE BODY nome_pacote
-- {IS ou AS}

-- [ variáveis ]

-- [ especificação dos cursores ]

-- [ especificação dos módulos ]

--     [BEGIN
--         sequencia_de_comandos
--     [EXCEPTION
--         exceções ] ]

-- END [nome_pacote ];

-- PACKAGE BODY EXAMPLES
CREATE OR REPLACE PACKAGE BODY rh AS

    FUNCTION descobrir_salario (
        p_id   IN emp.empno%TYPE
    ) RETURN NUMBER IS
        v_salario   emp.sal%TYPE := 0;
    BEGIN
        SELECT sal
        INTO   v_salario
        FROM   emp
        WHERE  empno = p_id;

        RETURN v_salario;
    END descobrir_salario;

    PROCEDURE reajuste (
        v_codigo_emp    IN emp.empno%TYPE,
        v_porcentagem   IN NUMBER DEFAULT 25
    )
        IS
    BEGIN
        UPDATE emp
        SET    sal = sal + ( sal * ( v_porcentagem / 100 ) )
        WHERE  empno = v_codigo_emp;

        COMMIT;
    END reajuste;

END rh;
/

-- USING package
SET SERVEROUTPUT ON

DECLARE
    v_sal   NUMBER(8,2);
BEGIN
    v_sal := rh.descobrir_salario(7782);
    dbms_output.put_line(v_sal);
END;
/

SELECT rh.descobrir_salario(7792)
FROM dual;
/

SET SERVEROUTPUT ON

DECLARE
    v_sal   NUMBER(8,2);
BEGIN
    v_sal := rh.descobrir_salario(7782);
    dbms_output.put_line('Salario atual - ' || v_sal);
    rh.reajuste(7782,faculdade.cnota);
    v_sal := rh.descobrir_salario(7782);
    dbms_output.put_line('Salario atualizado - ' || v_sal);
END;
/