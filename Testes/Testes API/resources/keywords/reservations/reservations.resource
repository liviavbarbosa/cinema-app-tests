*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /reservations
Resource         ../../support/common/common.resource
 
*** Keywords ***
GET Endpoint /reservations/me
    [Arguments]    ${token}
    &{header}    Create Dictionary    Authorization=Bearer ${token}
    ${response}    GET On Session    cinema-app       /reservations/me     headers=${header}    expected_status=any
    Set Test Variable        ${response}

GET Endpoint /reservations/id
    [Arguments]    ${id_reservation}    ${token}
    &{header}    Create Dictionary    Authorization=Bearer ${token}
    ${response}    GET On Session    cinema-app       /reservations/${id_reservation}     headers=${header}    expected_status=any
    Set Test Variable        ${response}  

POST Endpoint /reservations
    [Arguments]    ${reservation}           ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    POST On Session    cinema-app       /reservations      headers=${header}    json=${reservation}      expected_status=any
    ${id_reservation}=      Evaluate           $response.json().get("data", {}).get("_id")
    IF    "${id_reservation}" != "None"
        Set Test Variable    ${id_reservation}    ${id_reservation}
    END
    Set Test Variable        ${response}

PUT Endpoint /reservations/id
    [Arguments]    ${id_reservation}        ${reservation}         ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    PUT On Session    cinema-app       /reservations/${id_reservation}      headers=${header}    json=${reservation}      expected_status=any
    Set Test Variable        ${response}

DELETE Endpoint /reservations/id
    [Arguments]    ${id_reservation}        ${token}  
    &{header}      Create Dictionary       Authorization=Bearer ${token}
    ${response}    DELETE On Session    cinema-app       /reservations/${id_reservation}      headers=${header}    expected_status=any
    Set Test Variable        ${response}