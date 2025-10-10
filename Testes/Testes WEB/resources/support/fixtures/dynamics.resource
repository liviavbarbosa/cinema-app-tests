*** Settings ***
Documentation    Keywords ara a geração de inputs utilizados nos cenários de teste
Resource         ../common/common.resource

*** Keywords ***
Criar Usuario Comum
    ${name}        FakerLibrary.Name
    ${email}       FakerLibrary.Free Email
    ${password}    FakerLibrary.Password
    
    &{user}       Create Dictionary    
    ...           name=${name}
    ...           email=${email}
    ...           password=${password}
    RETURN        ${user}

Criar Dados para Atualizar Usuario
    [Arguments]    ${user}
    ${name}        FakerLibrary.Name
    ${password}    FakerLibrary.Password

    &{user}        Create Dictionary    
    ...            name=${name}
    ...            currentPassword=${user["password"]}
    ...            newPassword=${password}
    RETURN         ${user}