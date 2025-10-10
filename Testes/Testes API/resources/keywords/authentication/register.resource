*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste do Endpoint /auth/register
Resource         ../../support/common/common.resource
 
*** Keywords ***
POST Endpoint /auth/register
    [Arguments]    ${user}     
    ${response}    POST On Session    cinema-app       /auth/register      json=${user}      expected_status=any
    Set Test Variable        ${response}