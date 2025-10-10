*** Settings ***
Documentation    Elementos e ações da página inicial
Resource         ../support/common/common.resource

*** Keywords ***
Acessar página inicial
    Go To    ${BASE_URL}
    Wait For Elements State    xpath=//h1 >> text="Welcome to Cinema App"   visible    5

Usuario deve estar logado
    Wait For Elements State    xpath=//h1 >> text="Welcome to Cinema App"   visible    5

Ver detalhes do filme
    [Arguments]    ${movie_title}
    Scroll To Element    xpath=//div[@class="movie-card" and .//h3[contains(text(), "${movie_title}")]]//a[contains(., "Detalhes")]
    Click                xpath=//div[@class="movie-card" and .//h3[contains(text(), "${movie_title}")]]//a[contains(., "Detalhes")]
    Wait For Elements State    css=.movie-info >> text="${movie_title}"   visible    5