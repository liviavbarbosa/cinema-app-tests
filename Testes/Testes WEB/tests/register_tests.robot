*** Settings ***
Documentation    Cenários de teste para o módulo de cadastro 
Resource         ../resources/support/common/common.resource

Suite Setup       Criar Sessao
Suite Teardown    Take Screenshot

*** Test Cases ***
CT005: Registro de usuário com campos válidos
    Acessar página de cadastro
    ${user}=    Criar Usuario Comum
    Preencher campos de cadastro    ${user}
    Usuario deve estar cadastrado
    Alerta deveria ser    Conta criada com sucesso!
    Remover usuario do database    ${user}


CT009: Registro de usuário com e-mail já utilizado
    Acessar página de cadastro
    ${user}=    Criar Usuario Comum
    Inserir usuario no database     ${user}
    Preencher campos de cadastro    ${user}
    Alerta deveria ser    User already exists
    Remover usuario do database    ${user}