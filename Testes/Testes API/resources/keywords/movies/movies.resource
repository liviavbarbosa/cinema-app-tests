*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /movies
Resource         ../../support/common/common.resource
 
*** Keywords ***
GET Endpoint /movies
    ${response}    GET On Session    cinema-app       /movies     expected_status=any
    Set Test Variable        ${response}

GET Endpoint /movies/id
    [Arguments]    ${id_movie}
    ${response}    GET On Session    cinema-app       /movies/${id_movie}     expected_status=any
    Set Test Variable        ${response}

POST Endpoint /movies
    [Arguments]    ${movie}           ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    POST On Session    cinema-app       /movies      headers=${header}    json=${movie}      expected_status=any
    Set Test Variable        ${response}

PUT Endpoint /movies/id
    [Arguments]    ${id_movie}        ${movie}         ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    PUT On Session    cinema-app       /movies/${id_movie}      headers=${header}    json=${movie}      expected_status=any
    Set Test Variable        ${response}

DELETE Endpoint /movies/id
    [Arguments]    ${id_movie}        ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    DELETE On Session    cinema-app       /movies/${id_movie}      headers=${header}    expected_status=any
    Set Test Variable        ${response}