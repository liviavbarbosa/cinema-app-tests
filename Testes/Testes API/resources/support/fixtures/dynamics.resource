*** Settings ***
Documentation    Keywords ara a geração de inputs utilizados nos cenários de teste
Library          FakerLibrary

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