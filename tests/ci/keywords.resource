*** Settings ***
Library    OperatingSystem
Library    String
Library    Collections
Library    ${CURDIR}/libraries/postgres_container.py

Suite Setup       Inicializar Banco
Suite Teardown    Finalizar Banco

*** Variables ***
${CSV_FILE}     ${CURDIR}/usuarios.csv
${TABLE_NAME}   usuarios

*** Keywords ***
Inicializar Banco
    ${db}=    Start Postgres Container

    Set Suite Variable    ${CONN}          ${db}[conn]
    Set Suite Variable    ${DB_HOST}       ${db}[host]
    Set Suite Variable    ${DB_PORT}       ${db}[port]
    Set Suite Variable    ${DB_NAME}       ${db}[dbname]
    Set Suite Variable    ${DB_USER}       ${db}[user]
    Set Suite Variable    ${DB_PASSWORD}   ${db}[password]

Criar Tabela
    ${sql}=    Catenate    SEPARATOR=  
    ...    CREATE TABLE IF NOT EXISTS ${TABLE_NAME}
    ...    (id SERIAL PRIMARY KEY,
    ...    nome VARCHAR(255),
    ...    data_nascimento DATE,
    ...    sexo VARCHAR(10),
    ...    estado_civil VARCHAR(20),
    ...    naturalidade VARCHAR(100),
    ...    nacionalidade VARCHAR(100))

    ${cur}=    Evaluate    ${CONN}.cursor()
    ${cur}.execute    ${sql}
    ${CONN}.commit()
    ${cur}.close()

Inserir Dados
    ${content}=    Get File    ${CSV_FILE}
    ${lines}=      Split To Lines    ${content}

    ${data_lines}=    Get Slice From List    ${lines}    1

    FOR    ${line}    IN    @{data_lines}

        ${line}=    Strip String    ${line}
        IF    '${line}' == ''
            CONTINUE
        END

        ${data}=    Split String    ${line}    ,

        Insert User
        ...    ${data}[0]
        ...    ${data}[1]
        ...    ${data}[2]
        ...    ${data}[3]
        ...    ${data}[4]
        ...    ${data}[5]
    END

Finalizar Banco
    Stop Postgres Container
    Close Connection