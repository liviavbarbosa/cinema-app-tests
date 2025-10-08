*** Settings ***
Documentation    Cenários de teste para o módulo de autenticação da API
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT001: Login de usuário com credenciais válidas
    [Tags]       auth
    ${user}=     Criar Usuario Comum
    Inserir usuario no database     ${user}

    POST Endpoint /auth/login       ${user}

    Remover usuario do database    ${user}

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    name    email    role    token


CT005: Registro de usuário com campos válidos
    [Tags]       auth
    ${user}=     Criar Usuario Comum
    POST Endpoint /auth/register    ${user}

    Remover usuario do database    ${user}

    Validar Status Code             201
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    name    email    role    token


CT009: Registro de usuário com e-mail já utilizado
    [Tags]       auth
    ${user}=     Criar Usuario Comum
    Set To Dictionary    ${user}    email=usuariocomum@teste.com
    POST Endpoint /auth/register    ${user}

    Validar Status Code             400
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "User already exists"


CT010: Busca de usuário atual com token válido
    [Tags]       auth 
    ${user}=     Criar Usuario Comum
    Inserir usuario no database    ${user}

    POST Endpoint /auth/login      ${user}
    GET Endpoint /auth/me          ${TOKEN} 

    Remover usuario do database    ${user}

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    name    email    role


CT012: Atualização de usuário com campos válidos
    [Tags]    auth
    ${user}=     Criar Usuario Comum
    Inserir usuario no database    ${user}

    POST Endpoint /auth/login    ${user}

    ${user_updated}=              Criar Dados para Atualizar Usuario    ${user}
    PUT Endpoint /auth/profile    ${user_updated}    ${TOKEN}

    Remover usuario do database    ${user}

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    name    email    role