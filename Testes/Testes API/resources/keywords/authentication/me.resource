*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /auth/me
Resource         ../../support/common/common.resource
 
*** Keywords ***
GET Endpoint /auth/me
    [Arguments]    ${token}
    &{header}      Create Dictionary    
    ...            Authorization=Bearer ${token}
    ${response}    GET On Session    cinema-app       /auth/me     headers=${header}      expected_status=any
    Set Test Variable        ${response}