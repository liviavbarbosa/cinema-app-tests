*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /auth/profile
Resource         ../../support/common/common.resource
 
*** Keywords ***
PUT Endpoint /auth/profile
    [Arguments]    ${user}    ${token}   
    &{header}      Create Dictionary    
    ...            Authorization=Bearer ${token}
    ${response}    PUT On Session    cinema-app       /auth/profile      json=${user}    headers=${header}    expected_status=any
    Set Test Variable        ${response}

Criar Dados para Atualizar Usuario
    [Arguments]    ${user}
    ${name}        FakerLibrary.Name
    &{user}        Create Dictionary    
    ...            name=${name}
    ...            currentPassword=${user["password"]}
    ...            newPassword=mudada123
    RETURN         ${user}