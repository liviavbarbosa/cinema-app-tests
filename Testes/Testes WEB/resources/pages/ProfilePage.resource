*** Settings ***
Documentation    Elementos e ações da página de perfil
Resource         ../support/common/common.resource

*** Keywords ***
Preencher campos de atualização de perfil
    [Arguments]    ${user}
    ${element_name}            Set Variable    id=name
    ${element_password}        Set Variable    id=currentPassword
    ${element_new_password}    Set Variable    id=newPassword
    ${element_confirm}         Set Variable    id=confirmNewPassword

    Click          ${element_name}
    Fill Text      ${element_name}             ${user["name"]}

    Scroll To Element    css=button[type="submit"]

    Click          ${element_password}
    Fill Text      ${element_password}         ${user["currentPassword"]}

    Click          ${element_new_password}
    Fill Text      ${element_new_password}     ${user["newPassword"]}

    Click          ${element_confirm}
    Fill Text      ${element_confirm}          ${user["newPassword"]}

    Click                css=button[type="submit"]