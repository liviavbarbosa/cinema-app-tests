*** Settings ***
Documentation    Cenários de teste para o módulo de filmes da API
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT017: Busca válida de lista dos filmes cadastrados
    [Tags]    movies
    GET Endpoint /movies

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    title    synopsis    director    genres    
    ...                             duration        classification          poster    
    ...                             releaseDate    


CT018: Busca de filme com id válido
    [Tags]    movies
    ${movie}=    Criar Filme
    Inserir filme no database    ${movie}

    ${id_movie}=        Pegar id do filme    ${movie}
    GET Endpoint /movies/id      ${id_movie}

    Remover filme do database    ${id_movie}

    Validar Status Code             200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    title    synopsis    director    genres    
    ...                             duration        classification          poster    
    ...                             releaseDate     createdAt


CT021: Cadastro de filme com campos válidos como usuário administrador
    [Tags]    movies
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    ${movie}=    Criar Filme
    POST Endpoint /movies    ${movie}       ${TOKEN}

    Remover filme do database       ${id_movie}
    Remover usuario do database     ${user}

    Validar Status Code             201
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    _id    title    synopsis    director    genres    
    ...                             duration        classification          poster    
    ...                             releaseDate     createdAt
    

CT024: Cadastro de filme como usuário regular
    [Tags]    movies
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    POST Endpoint /auth/login               ${user}

    ${movie}=    Criar Filme
    POST Endpoint /movies    ${movie}       ${TOKEN}

    Remover usuario do database     ${user}

    Validar Status Code             403
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "User role user is not authorized to access this route"


CT025: Atualização de filme como usuário administrador com campos válidos
    [Tags]    movies
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    ${movie}=    Criar Filme
    POST Endpoint /movies    ${movie}       ${TOKEN}

    ${movie_updated}=    Criar Filme
    PUT Endpoint /movies/id    ${id_movie}    ${movie_updated}    ${TOKEN}

    Remover filme do database      ${id_movie}
    Remover usuario do database    ${user}

    Validar Status Code            200
    Validar se Obteve Sucesso
    Validar Conteudo da Resposta    title    synopsis    director    genres    duration
    ...                             classification       poster      releaseDate  
    

CT030: Exclusão de filme como usuário administrador 
    [Tags]    movies
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    Atualizar role do usuario para admin    ${user["email"]}
    POST Endpoint /auth/login               ${user}

    ${movie}=    Criar Filme
    POST Endpoint /movies    ${movie}       ${TOKEN}

    DELETE Endpoint /movies/id              ${id_movie}    ${TOKEN}

    Remover filme do database      ${id_movie}
    Remover usuario do database    ${user}

    Validar Status Code            200
    Validar se Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "Movie removed"


CT031: Exclusão de filme como visitante
    [Tags]    movies
    ${movie}=    Criar Filme
    Inserir filme no database               ${movie} 

    ${id_movie}=    Pegar id do filme       ${movie} 
    DELETE Endpoint /movies/id              ${id_movie}    ${EMPTY}

    Remover filme do database      ${id_movie}

    Validar Status Code            401
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "Not authorized to access this route"


CT032: Exclusão de filme como usuário regular
    [Tags]    movies
    ${user}=     Criar Usuario Comum
    Inserir usuario no database             ${user}
    POST Endpoint /auth/login               ${user}

    ${movie}=    Criar Filme
    Inserir filme no database               ${movie}   

    Pegar id do filme                       ${movie}        
    DELETE Endpoint /movies/id              ${id_movie}    ${TOKEN}

    Remover filme do database      ${id_movie}
    Remover usuario do database    ${user}

    Validar Status Code            403
    Validar se nao Obteve Sucesso
    Validar se a Resposta Contem a Mensagem "User role user is not authorized to access this route"