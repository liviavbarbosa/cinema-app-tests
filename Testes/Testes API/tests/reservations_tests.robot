*** Settings ***
Documentation    Cenários de teste para o módulo de reservas da API
Resource         ../resources/support/common/common.resource

Suite Setup    Criar Sessao

*** Test Cases ***
CT034: Busca de reservas vinculadas a um usuário com token válido
    