*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /auth/login
Resource         ../../support/common/common.resource
 
*** Keywords ***
POST Endpoint /auth/login
    [Arguments]    ${user}     
    ${response}    POST On Session    cinema-app       /auth/login      json=${user}      expected_status=any
    ${token}=      Evaluate           $response.json().get("data", {}).get("token")
    IF    "${token}" != "None"
        Set Test Variable    ${TOKEN}    ${token}
    END
    Set Test Variable        ${response}