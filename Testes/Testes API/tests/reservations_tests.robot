*** Settings ***
Documentation    Cenários de teste para o módulo de reservas da API
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT034: Busca de reservas vinculadas a um usuário com token válido
    [Tags]    reservations
    ${user}=    Criar Usuario Comum
    Inserir usuario no database    ${user}
    POST Endpoint /auth/login      ${user}

    Criar Reserva Completa

    GET Endpoint /reservations/me    ${TOKEN}

    Remover Dados da Reserva    ${id_movie}    ${id_theater}    ${id_session}    ${id_reservation}    ${user}

    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     user     session     seats     totalPrice     
    ...                             status        paymentStatus    paymentMethod    paymentDate    
    ...                             createdAt
    

CT038: Busca de reserva com id válido
    [Tags]    reservations
    ${user}=    Criar Usuario Comum
    Inserir usuario no database    ${user}
    POST Endpoint /auth/login      ${user}

    Criar Reserva Completa

    GET Endpoint /reservations/id    ${id_reservation}    ${TOKEN}

    Remover Dados da Reserva    ${id_movie}    ${id_theater}    ${id_session}    ${id_reservation}    ${user}

    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     user     session     seats     totalPrice     
    ...                             status        paymentStatus    paymentMethod    paymentDate    
    ...                             createdAt
    

CT041: Cadastro de reserva com campos válidos 
    [Tags]    reservations
    ${user}=    Criar Usuario Comum
    Inserir usuario no database    ${user}
    POST Endpoint /auth/login      ${user}

    Criar Reserva Completa
    Remover Dados da Reserva    ${id_movie}    ${id_theater}    ${id_session}    ${id_reservation}    ${user}

    Validar Status Code    201
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     user     session          totalPrice     
    ...                             status        paymentStatus    paymentMethod    paymentDate    
    ...                             createdAt
    

CT043: Cadastro de reserva com assentos já reservados
    [Tags]    reservations
    ${user}=    Criar Usuario Comum
    Inserir usuario no database    ${user}
    POST Endpoint /auth/login      ${user}

    Criar Reserva Completa Duplicada
    Remover Dados da Reserva       ${id_movie}    ${id_theater}    ${id_session}    ${id_reservation}    ${user}

    Validar Status Code    400
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "The following seats are not available: "


CT046: Atualização de reserva com campos válidos como usuário administrador
    [Tags]    reservations
    ${user}=    Criar Usuario Comum
    Inserir usuario no database    ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login      ${user}

    Criar Reserva Completa
    ${reservation_updated}=    Criar Dados para Atualizar Reserva
    PUT Endpoint /reservations/id    ${id_reservation}    ${reservation_updated}    ${TOKEN}

    Remover Dados da Reserva       ${id_movie}    ${id_theater}    ${id_session}    ${id_reservation}    ${user}

    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     user     session          totalPrice     
    ...                             status        paymentStatus    paymentMethod    paymentDate    
    ...                             createdAt
    

CT051: Exclusão de reserva como usuário administrador 
    [Tags]    reservations
    ${user}=    Criar Usuario Comum
    Inserir usuario no database    ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login      ${user}

    Criar Reserva Completa
    DELETE Endpoint /reservations/id    ${id_reservation}    ${TOKEN}

    Remover Dados da Reserva       ${id_movie}    ${id_theater}    ${id_session}    ${id_reservation}    ${user}

    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     user     session          totalPrice     
    ...                             status        paymentStatus    paymentMethod    paymentDate    
    ...                             createdAt