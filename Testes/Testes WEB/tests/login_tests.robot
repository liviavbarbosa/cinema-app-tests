*** Settings ***
Documentation    Cenários de teste para o módulo de login 
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT001: Login de usuário com credenciais válidas
    Acessar página de login
    ${user}=    Criar Usuario Comum
    Inserir usuario no database    ${user}
    Preencher campos de login      ${user}
    Usuario deve estar logado
    Alerta deveria ser    Login realizado com sucesso!
    Remover usuario do database    ${user}