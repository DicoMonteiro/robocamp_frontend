*** Settings ***
Documentation        Cadastro de Produtos no Catálogo
...                  Sendo um administrador de catálogo
...                  Quero cadastrar produtos
...                  Para que eu possa disponibiliza-los na loja virtual

Resource             ../resources/actions.robot

Suite Setup           Product Form Session
Suite Teardown        Close Session

# Deu ruim incluindo o Reload Page, pois quando loga, ele já da um refresh na tela, fazendo com que a automação se perca
Test Setup            Reload Page

# Test Setup            Tentative Create Product
Test Teardown         After Test

Test Template         Tentativa de cadastro
    

*** Keywords ***
Tentativa de cadastro
    [tags]    tentativa_cadastro
    [Arguments]    ${file_name}        ${message}
    
    Dado que eu tenho um novo produto   ${file_name}
    Quando eu tento cadastrar o produto
    Então devo ver uma mensagem informativa     ${message}

*** Test Cases ***            produto             saida
Nome não informado            streetf2.json       Oops - Informe o nome do produto!
Preço não informado           shimobi.json        Oops - Informe o preço também!
Categoria não selecionada     kidchamelon.json    Oops - Selecione uma categoria!



  