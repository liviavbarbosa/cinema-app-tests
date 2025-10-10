*** Settings ***
Documentation    Elementos e ações da página de reservas
Resource         ../support/common/common.resource

*** Keywords ***
Fazer reserva de sessão
    [Arguments]    ${movie_title}    ${session_time}    ${session_theater}    
    Scroll To Element    xpath=//div[contains(., "${session_time}") and contains(., "${session_theater}")]//a[contains(@class, 'session-button')]
    Click                xpath=//div[contains(., "${session_time}") and contains(., ${session_theater})]//a[contains(@class, 'session-button')]

Selecionar assentos
    [Arguments]    @{seats}
    FOR    ${seat}    IN    @{seats}
        Scroll To Element    xpath=//button[title=${seat}]
        Click                xpath=//button[title=${seat}]
    END

Realizar checkout
    [Arguments]    ${payment_method}
    Click    css=.payment-method >> text=${payment_method}
    Click    css=.btn >> text="Finalizar Compra"