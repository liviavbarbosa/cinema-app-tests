*** Settings ***
Documentation    Cenários de teste para o módulo de autenticação do sistema
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT001: Login de usuário com credenciais válidas
    [Tags]       login
    ${user}=     Criar Usuario Comum
    Inserir usuario no database     ${user}

    POST Endpoint /auth/login       ${user}

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    name    email    role    token

    Remover usuario do database    ${user}


CT005: Registro de usuário com campos válidos
    [Tags]       register
    ${user}=     Criar Usuario Comum
    POST Endpoint /auth/register    ${user}

    Validar Status Code             201
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    name    email    role    token

    Remover usuario do database    ${user}


CT009: Registro de usuário com e-mail já utilizado
    [Tags]       register
    ${user}=     Criar Usuario Comum
    Set To Dictionary    ${user}    email=usuariocomum@teste.com
    POST Endpoint /auth/register    ${user}

    Validar Status Code             400
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "User already exists"


CT010: Busca de usuário atual com token válido
    [Tags]       me 
    ${user}=     Criar Usuario Comum
    Inserir usuario no database    ${user}

    POST Endpoint /auth/login      ${user}
    GET Endpoint /auth/me          ${TOKEN} 

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    name    email    role

    Remover usuario do database    ${user}


CT012: Atualização de usuário com campos válidos
    [Tags]    profile
    ${user}=     Criar Usuario Comum
    Inserir usuario no database    ${user}

    POST Endpoint /auth/login    ${user}

    ${user_updated}=              Criar Dados para Atualizar Usuario    ${user}
    PUT Endpoint /auth/profile    ${user_updated}    ${TOKEN}

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    name    email    role

    Remover usuario do database    ${user}