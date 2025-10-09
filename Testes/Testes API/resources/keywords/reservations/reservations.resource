*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /reservations
Resource         ../../support/common/common.resource
 
*** Keywords ***
GET Endpoint /reservations
    ${response}    GET On Session    cinema-app       /movies     expected_status=any
    Set Test Variable        ${response}

GET Endpoint /reservations/id
    [Arguments]    ${id_movie}
    ${response}    GET On Session    cinema-app       /movies/${id_movie}     expected_status=any
    Set Test Variable        ${response}

GET Endpoint /reservations/me
    [Arguments]    ${token}
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    GET On Session    cinema-app       /reservations/me    headers=${header}    expected_status=any
    Set Test Variable        ${response}

POST Endpoint /reservations
    [Arguments]    ${movie}           ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    POST On Session    cinema-app       /movies      headers=${header}    json=${movie}      expected_status=any
    Set Test Variable        ${response}

PUT Endpoint /reservations/id
    [Arguments]    ${id_movie}        ${movie}         ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    PUT On Session    cinema-app       /movies/${id_movie}      headers=${header}    json=${movie}      expected_status=any
    Set Test Variable        ${response}

DELETE Endpoint /reservations/id
    [Arguments]    ${id_movie}        ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    DELETE On Session    cinema-app       /movies/${id_movie}      headers=${header}    expected_status=any
    Set Test Variable        ${response}