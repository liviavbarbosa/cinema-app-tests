*** Settings ***
Documentation    Ações e elementos do componente de mensagens de alertas
Library          Browser

*** Keywords ***
Alerta deveria ser
    [Arguments]                ${expected_text}
    Wait For Elements State    css=.alerts-container >> text=${expected_text}    
    ...                        visible    5

Modal deveria ter mensagem
    [Arguments]                ${expected_text}
    Wait For Elements State    xpath=//p >> text=${expected_text}  
    ...                        visible    5