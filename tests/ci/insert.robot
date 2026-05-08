*** Settings ***
Resource    keywords.resource

Suite Setup       Inicializar Banco
Suite Teardown    Finalizar Banco

*** Test Cases ***
Inserir Pessoas Do CSV No Banco
    Criar Tabela
    Inserir Dados
