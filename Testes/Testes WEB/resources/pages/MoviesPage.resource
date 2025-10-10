*** Settings ***
Documentation    Elementos e ações da página de filmes em cartaz
Resource         ../support/common/common.resource

*** Keywords ***
Acessar página de filmes em cartaz
    Go To    ${BASE_URL}/movies
    Wait For Elements State    xpath=//h1 >> text="Filmes em Cartaz"   visible    5

Buscar filme por título 
    [Arguments]    ${movie_title}
    ${element}     Set Variable         css=input[placeholder="Buscar filmes..."] 
    Click          ${element}
    Fill Text      ${element}           ${movie_title}

Buscar filmes por gênero
    [Arguments]    ${genre}
    ${element}     Set Variable         css=select
    Click          ${element}
    
Filme deve aparecer como resultado de busca
    [Arguments]    ${movie_title}
    Wait For Elements State                     css=.movie-title >> text=${movie_title}       visible        5