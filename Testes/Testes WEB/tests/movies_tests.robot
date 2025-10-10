*** Settings ***
Documentation    Cenários de teste para o módulo de filmes 
Resource         ../resources/support/common/common.resource

Suite Setup       Criar Sessao
Suite Teardown    Take Screenshot

*** Test Cases ***
CT119: Busca de filme por título válido
    Acessar página de filmes em cartaz
    Buscar filme por título    Inception
    Filme deve aparecer como resultado de busca    Inception