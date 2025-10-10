*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste
Library          RequestsLibrary
Library          Collections
Library          ../libs/database.py

Resource         env.resource
Resource         ../../keywords/authentication/login.resource
Resource         ../../keywords/authentication/register.resource
Resource         ../../keywords/authentication/me.resource
Resource         ../../keywords/authentication/profile.resource
Resource         ../../keywords/movies/movies.resource
Resource         ../../keywords/theaters/theaters.resource
Resource         ../../keywords/sessions/sessions.resource
Resource         ../../keywords/reservations/reservations.resource
Resource         ../../keywords/users/users.resource
Resource         ../fixtures/dynamics.resource

*** Keywords ***
Criar Sessao
    Create Session    cinema-app    ${URL_BASE}

Validar Status Code 
    [Arguments]                    ${status_code}
    Should Be True                 ${response.status_code}==${status_code}
    
Validar se a Resposta Contem a Mensagem "${mensagem}"
    Should Contain        ${response.json()["message"]}     ${mensagem}

Validar se Obteve Sucesso 
    Should Be True        ${response.json()["success"]} 

Validar se nao Obteve Sucesso 
    Should Not Be True        ${response.json()["success"]} 

Validar Conteudo da Resposta    
    [Arguments]           @{dados}
    ${data}=    Set Variable    ${response.json()["data"]}
    
    ${is_list}=    Evaluate    isinstance($data, list)
    IF    ${is_list}
        FOR    ${item}    IN    @{data}
            FOR    ${campo}    IN    @{dados}
                Dictionary Should Contain Key    ${item}    ${campo}
            END
        END
    ELSE
        FOR    ${campo}    IN    @{dados}
            Dictionary Should Contain Key    ${data}    ${campo}    
        END  
    END