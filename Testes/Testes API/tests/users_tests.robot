*** Settings ***
Documentation    Cenários de teste para o módulo de usuários da API
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT097: Busca válida de lista dos usuários cadastrados como usuário administrador
    [Tags]    users
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    GET Endpoint /users    ${TOKEN}

    Remover usuario do database    ${user}

    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     name     email    role     createdAt


CT098: Busca de usuário com id válido
    [Tags]    users
    ${user}=     Criar Usuario Comum
    Inserir usuario no database              ${user}
    Atualizar role do usuario para admin     ${user["email"]}
    POST Endpoint /auth/login                ${user}

    ${user_test}=     Criar Usuario Comum
    Inserir usuario no database              ${user_test}

    ${user_id}=       Pegar id do usuario    ${user_test}
    GET Endpoint /users/id    ${user_id}     ${TOKEN}

    Remover usuario do database    ${user}
    Remover usuario do database    ${user_test}

    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     name     email    role     createdAt


CT102: Atualização de usuário como usuário administrador com campos válidos
    [Tags]    users
    ${user}=     Criar Usuario Comum
    Inserir usuario no database              ${user}
    Atualizar role do usuario para admin     ${user["email"]}
    POST Endpoint /auth/login                ${user}

    ${user_test}=     Criar Usuario Comum
    Inserir usuario no database              ${user_test}
    
    ${user_id}=       Pegar id do usuario    ${user_test}
    ${user_test_updated}=    Criar Dados para Atualizar Usuario Admin
    PUT Endpoint /users/id    ${user_id}     ${user_test_updated}    ${TOKEN}

    Remover usuario do database    ${user}
    Remover usuario do database    ${user_test}
    Remover usuario do database    ${user_test_updated}
    
    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     name     email    role     


CT107: Atualização de usuário com e-mail já utilizado 
    [Tags]    users
    ${user}=     Criar Usuario Comum
    Inserir usuario no database              ${user}
    Atualizar role do usuario para admin     ${user["email"]}
    POST Endpoint /auth/login                ${user}

    ${user_test}=     Criar Usuario Comum
    Inserir usuario no database              ${user_test}
    
    ${user_id}=       Pegar id do usuario    ${user_test}
    ${user_test_updated}=    Criar Dados para Atualizar Usuario Admin
    Set To Dictionary         ${user_test_updated}        email=${user["email"]}
    PUT Endpoint /users/id    ${user_id}     ${user_test_updated}     ${TOKEN}

    Remover usuario do database    ${user}
    Remover usuario do database    ${user_test}
    Remover usuario do database    ${user_test_updated}
    
    Validar Status Code    400
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "Duplicate field value entered"


CT108: Exclusão de usuário como usuário administrador
    [Tags]    users 
    ${user}=     Criar Usuario Comum
    Inserir usuario no database                ${user}
    Atualizar role do usuario para admin       ${user["email"]}
    POST Endpoint /auth/login                  ${user}

    ${user_test}=     Criar Usuario Comum
    Inserir usuario no database                ${user_test}
    
    ${user_id}=       Pegar id do usuario      ${user_test}
    DELETE Endpoint /users/id    ${user_id}    ${TOKEN}

    Remover usuario do database    ${user}
    
    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "User removed"


CT109: Exclusão de usuário como visitante
    [Tags]    users 
    ${user_test}=     Criar Usuario Comum
    Inserir usuario no database                  ${user_test}
    
    ${user_id}=       Pegar id do usuario        ${user_test}
    DELETE Endpoint /users/id      ${user_id}    ${EMPTY}

    Remover usuario do database    ${user_test}
    
    Validar Status Code    401
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "Not authorized to access this route"


CT110: Exclusão de usuário como usuário regular
    [Tags]    users 
    ${user}=     Criar Usuario Comum
    Inserir usuario no database                ${user}
    POST Endpoint /auth/login                  ${user}

    ${user_test}=     Criar Usuario Comum
    Inserir usuario no database                ${user_test}
    
    ${user_id}=       Pegar id do usuario      ${user_test}
    DELETE Endpoint /users/id    ${user_id}    ${TOKEN}

    Remover usuario do database    ${user}
    Remover usuario do database    ${user_test}
    
    Validar Status Code    403
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "User role user is not authorized to access this route"


CT112: Exclusão de usuário com reservas ativas
    [Tags]    users
    ${user_test}=    Criar Usuario Comum
    Inserir usuario no database    ${user_test}
    POST Endpoint /auth/login      ${user_test}

    Criar Reserva Completa

    ${user}=    Criar Usuario Comum
    Inserir usuario no database    ${user}
    Atualizar role do usuario para admin       ${user["email"]}
    POST Endpoint /auth/login      ${user}

    ${user_id}=       Pegar id do usuario      ${user_test}
    DELETE Endpoint /users/id    ${user_id}    ${TOKEN}

    Remover usuario do database    ${user}
    Remover Dados da Reserva    ${id_movie}    ${id_theater}    ${id_session}    ${id_reservation}    ${user_test}

    Validar Status Code    400
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "Cannot delete user with active reservations"