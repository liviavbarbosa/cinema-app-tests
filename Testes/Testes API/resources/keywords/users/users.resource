*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /users
Resource         ../../support/common/common.resource
 
*** Keywords ***
GET Endpoint /users
    [Arguments]    ${token}
    &{header}    Create Dictionary    Authorization=Bearer ${token}
    ${response}    GET On Session    cinema-app       /users     headers=${header}    expected_status=any
    Set Test Variable        ${response}

GET Endpoint /users/id
    [Arguments]    ${id_user}    ${token}
    &{header}    Create Dictionary    Authorization=Bearer ${token}
    ${response}    GET On Session    cinema-app       /users/${id_user}     headers=${header}    expected_status=any
    Set Test Variable        ${response}

PUT Endpoint /users/id
    [Arguments]    ${id_user}    ${user}    ${token}
    &{header}    Create Dictionary    Authorization=Bearer ${token}
    ${response}    PUT On Session    cinema-app       /users/${id_user}     headers=${header}    json=${user}    expected_status=any
    Set Test Variable        ${response}

DELETE Endpoint /users/id
    [Arguments]    ${id_user}    ${token}
    &{header}    Create Dictionary    Authorization=Bearer ${token}
    ${response}    DELETE On Session    cinema-app       /users/${id_user}     headers=${header}    expected_status=any
    Set Test Variable        ${response}