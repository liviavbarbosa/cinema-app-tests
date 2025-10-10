*** Settings ***
Documentation    Keywords ara a geração de inputs utilizados nos cenários de teste
Library          FakerLibrary
Library          String
Resource         ../common/common.resource

*** Keywords ***
Criar Usuario Comum
    ${name}       FakerLibrary.Name
    ${email}      FakerLibrary.Free Email
    
    &{user}       Create Dictionary    
    ...           name=${name}
    ...           email=${email}
    ...           password=teste123
    RETURN        ${user}

Criar Dados para Atualizar Usuario
    [Arguments]    ${user}
    ${name}        FakerLibrary.Name

    &{user}        Create Dictionary    
    ...            name=${name}
    ...            currentPassword=${user["password"]}
    ...            newPassword=mudada123
    RETURN         ${user}

Criar Dados para Atualizar Usuario Admin
    ${name}       FakerLibrary.Name
    ${email}      FakerLibrary.Free Email
    ${role}       Evaluate    random.choice(['user', 'admin'])    random

    &{user}       Create Dictionary    
    ...           name=${name}
    ...           email=${email}
    ...           role=${role}
    RETURN        ${user}

Criar Filme
    ${title}               FakerLibrary.Word    
    ${synopsis}            FakerLibrary.Paragraph
    ${director}            FakerLibrary.Name
    ${genres}              Evaluate    random.sample(['Action', 'Drama', 'Comedy', 'Thriller', 'Romance'], k=2)    random
    ${duration}            FakerLibrary.Random Int
    ${classification}      Evaluate    random.choice(['G', 'PG', 'PG-13', 'R', 'NC-17'])    random
    ${poster}              FakerLibrary.File Name
    ${releaseDate}         FakerLibrary.Date 

    &{movie}      Create Dictionary    
    ...           title=${title}
    ...           synopsis=${synopsis}
    ...           director=${director}
    ...           genres=${genres}
    ...           duration=${duration}
    ...           classification=${classification}
    ...           poster=${poster}
    ...           releaseDate=${releaseDate}
    
    RETURN        ${movie}

Criar Teatro
    ${name}               FakerLibrary.Name    
    ${capacity}           FakerLibrary.Random Int
    ${type}               Evaluate    random.choice(['standard', 'VIP', 'IMAX', '3D'])    random

    &{theater}      Create Dictionary    
    ...             name=${name}
    ...             capacity=${capacity}
    ...             type=${type}
    
    RETURN        ${theater}

Criar Sessao de Cinema
    [Arguments]    ${movie_id}    ${theater_id}
    ${datetime}           FakerLibrary.Date Time   
    ${fullPrice}          FakerLibrary.Random Int
    ${halfPrice}          FakerLibrary.Random Int

    ${datetime_str}=    Convert To String    ${datetime}

    &{session}      Create Dictionary    
    ...             movie=${movie_id}
    ...             theater=${theater_id}
    ...             datetime=${datetime_str}
    ...             fullPrice=${fullPrice}
    ...             halfPrice=${halfPrice}
    
    RETURN        ${session}

Criar Reserva 
    [Arguments]    ${session_id}
    ${row}=        Evaluate    random.choice(['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'])    random
    ${number}      FakerLibrary.Random Int    1    8   
    ${type}        Evaluate    random.choice(['full', 'half'])    random

    &{seats}       Create Dictionary    row=${row}    number=${number}    type=${type}   
    @{seats}       Create List      ${seats}
    ${paymentMethod}    Evaluate    random.choice(['credit_card', 'debit_card', 'pix', 'bank_transfer'])    random

    &{reservation}      Create Dictionary    
    ...                 session=${session_id}
    ...                 seats=${seats}
    ...                 paymentMethod=${paymentMethod}
    
    RETURN        ${reservation}

Criar Reserva Completa
    ${movie}=           Criar Filme
    Inserir filme no database     ${movie}

    ${theater}=         Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_movie}=        Pegar id do filme         ${movie}
    ${id_theater}=      Pegar id do teatro        ${theater}
    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}
    Inserir sessao no database    ${session}
    
    ${id_session}=       Pegar id da sessao      ${session}
    ${reservation}=      Criar Reserva              ${id_session}
    Set To Dictionary    ${reservation}    session=${id_session} 
    Set To Dictionary    ${reservation}    session=${id_session.__str__()}
    POST Endpoint /reservations            ${reservation}        ${TOKEN}

    Set Test Variable    ${id_movie}      ${id_movie}
    Set Test Variable    ${id_theater}    ${id_theater}
    Set Test Variable    ${id_session}    ${id_session}

Criar Dados para Atualizar Reserva
    ${status}           Evaluate    random.choice(['pending', 'confirmed', 'cancelled'])    random
    ${paymentStatus}    Evaluate    random.choice(['pending', 'completed', 'failed'])       random
    &{reservation}      Create Dictionary    
    ...                 status=${status}
    ...                 paymentStatus=${paymentStatus}
    RETURN              ${reservation}

Criar Reserva Completa Duplicada
    ${movie}=           Criar Filme
    Inserir filme no database     ${movie}

    ${theater}=         Criar Teatro
    Inserir teatro no database    ${theater}

    ${id_movie}=        Pegar id do filme         ${movie}
    ${id_theater}=      Pegar id do teatro        ${theater}
    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}
    Inserir sessao no database    ${session}
    
    ${id_session}=       Pegar id da sessao      ${session}
    ${reservation}=      Criar Reserva              ${id_session}
    Set To Dictionary    ${reservation}    session=${id_session} 
    Set To Dictionary    ${reservation}    session=${id_session.__str__()}
    POST Endpoint /reservations            ${reservation}        ${TOKEN}
    POST Endpoint /reservations            ${reservation}        ${TOKEN}

    Set Test Variable    ${id_movie}      ${id_movie}
    Set Test Variable    ${id_theater}    ${id_theater}
    Set Test Variable    ${id_session}    ${id_session}

Criar Sessao de Cinema Completa
    ${movie}=        Criar Filme
    POST Endpoint /movies      ${movie}       ${TOKEN}

    ${theater}=      Criar Teatro
    POST Endpoint /theaters    ${theater}     ${TOKEN}

    ${session}=         Criar Sessao de Cinema    ${id_movie}    ${id_theater}
    POST Endpoint /sessions       ${session}      ${TOKEN}

Remover Dados da Reserva
    [Arguments]    ${id_movie}    ${id_theater}    ${id_session}    ${id_reservation}    ${user}
    Remover filme do database      ${id_movie}
    Remover teatro do database     ${id_theater} 
    Remover sessao do database     ${id_session}

    IF    "${id_reservation}" != "${EMPTY}"
        Remover reserva do database    ${id_reservation}
    END

    IF    "${user}" != "${EMPTY}"
        Remover usuario do database    ${user}
    END

Remover Dados da Sessao
    [Arguments]    ${id_movie}    ${id_theater}    ${id_session}    ${user}
    Remover filme do database      ${id_movie}
    Remover teatro do database     ${id_theater}

    IF    "${id_session}" != "${EMPTY}"
        Remover sessao do database     ${id_session}
    END

    IF    "${user}" != "${EMPTY}"
        Remover usuario do database    ${user}
    END