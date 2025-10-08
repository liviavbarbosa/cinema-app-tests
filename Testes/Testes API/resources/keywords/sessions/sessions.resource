*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /sessions
Resource         ../../support/common/common.resource
 
*** Keywords ***
GET Endpoint /sessions
    ${response}    GET On Session    cinema-app       /sessions     expected_status=any
    Set Test Variable        ${response}

GET Endpoint /sessions/id
    [Arguments]    ${id_session}
    ${response}    GET On Session    cinema-app       /sessions/${id_session}     expected_status=any
    Set Test Variable        ${response}

POST Endpoint /sessions
    [Arguments]    ${session}           ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    POST On Session    cinema-app       /sessions      headers=${header}    json=${session}      expected_status=any
    Set Test Variable        ${response}

PUT Endpoint /sessions/id
    [Arguments]    ${id_session}        ${session}         ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    PUT On Session    cinema-app       /sessions/${id_session}      headers=${header}    json=${session}      expected_status=any
    Set Test Variable        ${response}

PUT Endpoint /sessions/id/reset-seats 
    [Arguments]    ${id_session}        ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    PUT On Session    cinema-app       /sessions/${id_session}/reset-seats      headers=${header}    expected_status=any
    Set Test Variable        ${response}

DELETE Endpoint /sessions/id
    [Arguments]    ${id_session}        ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    DELETE On Session    cinema-app       /sessions/${id_session}      headers=${header}    expected_status=any
    Set Test Variable        ${response}