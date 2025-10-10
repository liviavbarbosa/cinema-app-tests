*** Settings ***
Documentation    Cenários de teste para o módulo de perfil 
Resource         ../resources/support/common/common.resource

Suite Setup       Criar Sessao
Suite Teardown    Take Screenshot

*** Test Cases ***
CT012: Atualização de usuário com campos válidos
    Acessar página de login
    ${user}=    Criar Usuario Comum
    Inserir usuario no database    ${user}
    Preencher campos de login      ${user}
    Usuario deve estar logado

    Click    css=a[href="/profile"]
    ${new_user}=    Criar Dados para Atualizar Usuario    ${user}
    
    Preencher campos de atualização de perfil    ${new_user}
    Modal deveria ter mensagem    Perfil atualizado com sucesso
    
    Remover usuario do database    ${user}