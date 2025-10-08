*** Settings ***
Documentation    Keywords necessárias para executar os cenários de teste
Library          RequestsLibrary
Library          FakerLibrary
Library          Collections
Library          ../libs/database.py

Resource         env.resource
Resource         ../../keywords/authentication/login.resource
Resource         ../../keywords/authentication/register.resource
Resource         ../../keywords/authentication/me.resource
Resource         ../../keywords/authentication/profile.resource

*** Keywords ***
Criar Sessao
    Create Session    cinema-app    ${URL_BASE}

Criar Usuario Comum
    ${name}       FakerLibrary.Name
    ${email}      FakerLibrary.Free Email
    &{user}    Create Dictionary    
    ...           name=${name}
    ...           email=${email}
    ...           password=teste123
    RETURN        ${user}

Validar Status Code 
    [Arguments]                    ${status_code}
    Should Be True                 ${response.status_code}==${status_code}
    
Validar se a Resposta Contem "${palavra}"
    Should Contain        ${response.json()}                ${palavra}

Validar se a Resposta nao Contem "${palavra}"
    Should Not Contain    ${response.json()}                ${palavra}

Validar se a Resposta Contem a Mensagem "${mensagem}"
    Should Contain        ${response.json()["message"]}     ${mensagem}

Validar se Obteve Sucesso 
    Should Be True        ${response.json()["success"]} 

Validar se nao Obteve Sucesso 
    Should Not Be True        ${response.json()["success"]} 

Validar Conteudo da Resposta    
    [Arguments]           @{dados}
    FOR    ${campo}    IN    @{dados}
        Dictionary Should Contain Key    ${response.json()["data"]}    ${campo}    
    END  