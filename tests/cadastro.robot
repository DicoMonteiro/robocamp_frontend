*** Settings ***
Documentation        Cadastro de Produtos no Catálogo
...                  Sendo um administrador de catálogo
...                  Quero cadastrar produtos
...                  Para que eu possa disponibiliza-los 

Resource             ../resources/actions.robot

Suite Setup           Login Session
Suite Teardown        Close Session

Test Teardown         After Test


*** Test Cases ***
Disponibilizar o produto
    Dado que eu tenho um novo produto    dk.json
    Quando eu faço o cadastro desse produto
    Então visualizo este item no catálogo

Produto duplicado
    Dado que eu tenho um novo produto    master.json
    Mas este produto já foi cadastrado
    Quando eu faço o cadastro desse produto
    Então devo ver uma mensagem de erro   Oops - Este produto já foi cadastrado!