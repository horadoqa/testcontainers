*** Settings ***
Library    SeleniumLibrary



*** Variables ***
${URL}    https://serverest.dev/usuarios
${BROWSER}    chrome

*** Keywords ***
Acessar URL
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Fechar Navegador
    Close Browser

*** Test Cases ***
Acessar URL Do ServeRest
    Acessar URL
    Fechar Navegador