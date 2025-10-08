*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /theaters
Resource         ../../support/common/common.resource
 
*** Keywords ***
GET Endpoint /theaters
    ${response}    GET On Session    cinema-app       /theaters     expected_status=any
    Set Test Variable        ${response}

GET Endpoint /theaters/id
    [Arguments]    ${id_teatro}
    ${response}    GET On Session    cinema-app       /theaters/${id_teatro}     expected_status=any
    Set Test Variable        ${response}

POST Endpoint /theaters
    [Arguments]    ${theater}           ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    POST On Session    cinema-app       /theaters      headers=${header}    json=${theater}      expected_status=any
    Set Test Variable        ${response}

PUT Endpoint /theaters/id
    [Arguments]    ${id_theater}        ${theater}         ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    PUT On Session    cinema-app       /theaters/${id_theater}      headers=${header}    json=${theater}      expected_status=any
    Set Test Variable        ${response}

DELETE Endpoint /theaters/id
    [Arguments]    ${id_theater}        ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    DELETE On Session    cinema-app       /theaters/${id_theater}      headers=${header}    expected_status=any
    Set Test Variable        ${response}