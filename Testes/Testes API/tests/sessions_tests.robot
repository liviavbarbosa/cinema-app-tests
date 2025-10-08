*** Settings ***
Documentation    Cenários de teste para o módulo de sessões da API
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT055: Busca válida de lista de sessões cadastradas
    [Tags]    sessions
    GET Endpoint /sessions
    Validar Status Code    200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     movie    theater    fullPrice    halfPrice
    ...                             seats            createdAt
    

CT056: Busca de sessão com id válido
    [Tags]    sessions
    ${movie}=        Criar Filme
    Inserir filme no database     ${movie}

    ${theater}=      Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_movie}=        Pegar id do filme         ${movie}
    ${id_theater}=      Pegar id do teatro        ${theater}
    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}
    Inserir sessao no database    ${session}
    
    ${id_session}=        Pegar id da sessao        ${session}
    GET Endpoint /sessions/id     ${id_session}

    Remover filme do database     ${id_movie}
    Remover teatro do database    ${id_theater} 
    Remover sessao do database    ${id_session} 

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     movie    theater    datetime    fullPrice    
    ...                             halfPrice        seats      createdAt
    

CT058: Cadastro de sessão com campos válidos como usuário administrador
    [Tags]    sessions
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    ${movie}=        Criar Filme
    Inserir filme no database     ${movie}

    ${theater}=      Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_movie}=        Pegar id do filme         ${movie}
    ${id_theater}=      Pegar id do teatro        ${theater}
    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}

    Set To Dictionary    ${session}    movie=${id_movie}              theater=${id_theater}
    Set To Dictionary    ${session}    movie=${id_movie.__str__()}    theater=${id_theater.__str__()}

    POST Endpoint /sessions       ${session}      ${TOKEN}
    
    ${id_session}=        Pegar id da sessao        ${session}
    Remover filme do database     ${id_movie}
    Remover teatro do database    ${id_theater} 
    Remover sessao do database    ${id_session} 

    Validar Status Code             201
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     movie    theater    datetime    fullPrice    
    ...                             halfPrice        seats      createdAt
    

CT064: Atualização de sessão válida como usuário administrador
    [Tags]    sessions
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    ${movie}=        Criar Filme
    Inserir filme no database     ${movie}

    ${theater}=      Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_movie}=        Pegar id do filme         ${movie}
    ${id_theater}=      Pegar id do teatro        ${theater}
    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}
    Inserir sessao no database    ${session}

    ${session_updated}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}

    Set To Dictionary    ${session_updated}    movie=${id_movie}              theater=${id_theater}
    Set To Dictionary    ${session_updated}    movie=${id_movie.__str__()}    theater=${id_theater.__str__()}

    ${id_session}=        Pegar id da sessao          ${session}
    PUT Endpoint /sessions/id       ${id_session}     ${session_updated}      ${TOKEN}
    
    Remover filme do database     ${id_movie}
    Remover teatro do database    ${id_theater} 
    Remover sessao do database    ${id_session} 

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     movie    theater    datetime    fullPrice    
    ...                             halfPrice        seats      createdAt
    

# CT069: Atualização de sessão com reservas


CT070: Reset de sessão válida como usuário administrador
    [Tags]    sessions
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    ${movie}=        Criar Filme
    Inserir filme no database     ${movie}

    ${theater}=      Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_movie}=        Pegar id do filme         ${movie}
    ${id_theater}=      Pegar id do teatro        ${theater}
    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}
    Inserir sessao no database    ${session}

    ${session_updated}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}

    Set To Dictionary    ${session_updated}    movie=${id_movie}              theater=${id_theater}
    Set To Dictionary    ${session_updated}    movie=${id_movie.__str__()}    theater=${id_theater.__str__()}

    ${id_session}=        Pegar id da sessao          ${session}
    PUT Endpoint /sessions/id/reset-seats      ${id_session}     ${TOKEN}
    
    Remover filme do database     ${id_movie}
    Remover teatro do database    ${id_theater} 
    Remover sessao do database    ${id_session} 

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id     movie    theater    datetime    fullPrice    
    ...                             halfPrice        seats      createdAt
    

CT074: Exclusão de sessão como usuário administrador
    [Tags]    sessions
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    ${movie}=        Criar Filme
    Inserir filme no database     ${movie}

    ${theater}=      Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_movie}=        Pegar id do filme         ${movie}
    ${id_theater}=      Pegar id do teatro        ${theater}
    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}
    Inserir sessao no database    ${session}
    
    ${id_session}=        Pegar id da sessao        ${session}
    DELETE Endpoint /sessions/id     ${id_session}    ${TOKEN}

    Remover filme do database     ${id_movie}
    Remover teatro do database    ${id_theater} 

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "Session removed"


CT075: Exclusão de sessão como visitante
    [Tags]    sessions
    ${movie}=        Criar Filme
    Inserir filme no database     ${movie}

    ${theater}=      Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_movie}=        Pegar id do filme         ${movie}
    ${id_theater}=      Pegar id do teatro        ${theater}
    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}
    Inserir sessao no database    ${session}
    
    ${id_session}=        Pegar id da sessao        ${session}
    DELETE Endpoint /sessions/id     ${id_session}    ${EMPTY}

    Remover filme do database     ${id_movie}
    Remover teatro do database    ${id_theater} 

    Validar Status Code             401
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "Not authorized to access this route"


CT076: Exclusão de sessão como usuário regular
    [Tags]    sessions
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    POST Endpoint /auth/login               ${user}

    ${movie}=        Criar Filme
    Inserir filme no database     ${movie}

    ${theater}=      Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_movie}=        Pegar id do filme         ${movie}
    ${id_theater}=      Pegar id do teatro        ${theater}
    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}
    Inserir sessao no database    ${session}
    
    ${id_session}=        Pegar id da sessao        ${session}
    DELETE Endpoint /sessions/id     ${id_session}    ${TOKEN}

    Remover filme do database     ${id_movie}
    Remover teatro do database    ${id_theater} 

    Validar Status Code             403
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "User role user is not authorized to access this route"


# CT078: Exclusão de sessão com reservas confirmadas