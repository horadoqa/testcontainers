*** Settings ***
Resource    keywords.resource

Suite Setup     Setup Database Container
Suite Teardown  Teardown Database Container

*** Test Cases ***
Inserir Pessoas Do CSV No Banco
    Criar Tabela
    Inserir Dados