*** Settings ***
Documentation    Cenários de teste para o módulo de reservas 
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
# CT123: Reserva com seleção de assentos válidos
#     Acessar página de login
#     ${user}=    Criar Usuario Comum
#     Inserir usuario no database    ${user}
#     Preencher campos de login      ${user}
#     Usuario deve estar logado
#     Ver detalhes do filme      Inception
#     Fazer reserva de sessão    Inception    20:00    Theater 2 - 3D    
#     Selecionar assentos    Fileira E, Assento 5 - Status: available
#     Realizar checkout      Cartão de Crédito
#     Modal deveria ter mensagem    Sua reserva foi concluída com sucesso.