*** Settings ***
Documentation    Elementos e ações da página de cadastro
Resource         ../support/common/common.resource

*** Keywords ***
Acessar página de cadastro
    Go To    ${BASE_URL}/register
    Wait For Elements State    xpath=//h1 >> text="Cadastro"   visible    5

Preencher campos de cadastro
    [Arguments]    ${user}
    ${element_name}        Set Variable    id=name
    ${element_email}       Set Variable    id=email
    ${element_password}    Set Variable    id=password
    ${element_confirm}     Set Variable    id=confirmPassword

    Click          ${element_name}
    Fill Text      ${element_name}         ${user["name"]}

    Click          ${element_email}
    Fill Text      ${element_email}        ${user["email"]}

    Click          ${element_password}
    Fill Text      ${element_password}     ${user["password"]}

    Click          ${element_confirm}
    Fill Text      ${element_confirm}     ${user["password"]}

    Scroll To Element    css=button[type="submit"]
    Click                css=button[type="submit"]