*** Settings ***
Documentation    Elementos e ações da página de login
Resource         ../support/common/common.resource

*** Keywords ***
Acessar página de login
    Go To    ${BASE_URL}/login
    Wait For Elements State    xpath=//h1 >> text="Login"   visible    5

Preencher campos de login
    [Arguments]    ${user}
    ${element_email}    Set Variable    id=email
    ${element_password}    Set Variable    id=password

    Click          ${element_email}
    Fill Text      ${element_email}      ${user["email"]}
    Click          ${element_password}
    Fill Text      ${element_password}      ${user["password"]}
    Click          css=.btn >> text="Entrar"

Usuario deve estar cadastrado
    Wait For Elements State    xpath=//h1 >> text="Login"   visible    5