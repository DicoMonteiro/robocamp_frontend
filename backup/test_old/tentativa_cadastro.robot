*** Settings ***
Documentation        Cadastro de Produtos no Catálogo
...                  Sendo um administrador de catálogo
...                  Quero cadastrar produtos
...                  Para que eu possa disponibiliza-los 
Resource             ../resources/actions.robot

Suite Setup           Product Form Session
Suite Teardown        Close session

Test Setup            Reload Page
Test Teardown         After Test

# Dessa maneira todo Test Case implementado vai ser com base nesse template definido
Test Template         Tentativa de cadastro
    

*** Keywords ***
Tentativa de cadastro
    [Arguments]    ${file_name}        ${message}
    
    Dado que eu tenho um novo produto   ${file_name}
    Quando eu tento cadastrar o produto
    Então devo ver a mensagem informativa     ${message}

*** Test Cases ***            produto             saida
Nome não informado            streetf2.json       Oops - Informe o nome do produto!
Preço não informado           shimobi.json        Oops - Informe o preço também!
Categoria não selecionada     kidchamelon.json    Oops - Selecione uma categoria!



  