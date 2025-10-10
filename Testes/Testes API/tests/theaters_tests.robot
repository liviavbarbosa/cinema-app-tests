*** Settings ***
Documentation    Cenários de teste para o módulo de teatros da API
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT133: Busca válida de lista dos teatros cadastrados
    [Tags]    theaters
    GET Endpoint /theaters
    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     name     capacity    type    createdAt


CT079: Busca de teatro com id válido
    [Tags]    theaters
    ${theater}=    Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_theater}=    Pegar id do teatro     ${theater}
    GET Endpoint /theaters/id     ${id_theater}

    Remover teatro do database    ${id_theater}

    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     name     capacity    type    createdAt


CT081: Cadastro de teatro com campos válidos como usuário administrador
    [Tags]    theaters
    ${user}=    Criar Usuario Comum
    Inserir usuario no database              ${user}
    Atualizar role do usuario para admin     ${user["email"]}
    POST Endpoint /auth/login                ${user}    

    ${theater}=    Criar Teatro
    POST Endpoint /theaters    ${theater}    ${TOKEN}

    Remover teatro do database               ${id_theater}
    Remover usuario do database              ${user}

    Validar Status Code    201
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     name     capacity    type    createdAt


CT086: Atualização de teatro como usuário administrador com campos válidos
    [Tags]    theaters
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    ${theater}=    Criar Teatro
    POST Endpoint /theaters    ${theater}    ${TOKEN}

    ${theater_updated}=    Criar Teatro
    PUT Endpoint /theaters/id      ${id_theater}    ${theater_updated}    ${TOKEN}

    Remover teatro do database     ${id_theater}
    Remover usuario do database    ${user}

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    name     capacity    type


CT092: Exclusão de teatro como usuário administrador
    [Tags]    theaters
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    ${theater}=    Criar Teatro
    POST Endpoint /theaters    ${theater}    ${TOKEN}
    DELETE Endpoint /theaters/id             ${id_theater}    ${TOKEN}

    Remover teatro do database      ${id_theater}
    Remover usuario do database     ${user}

    Validar Status Code            200
    Validar se Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "Theater removed"

CT096: Exclusão de teatro com sessões ativas
    [Tags]    theaters
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    Criar Sessao de Cinema Completa
    DELETE Endpoint /theaters/id    ${id_theater}    ${TOKEN}
    
    Remover Dados da Sessao    ${id_movie}    ${id_theater}    ${id_session}    ${user}

    Validar Status Code             409
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "Cannot delete theater with active sessions"