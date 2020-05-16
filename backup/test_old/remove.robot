*** Settings ***
Documentation        Exclusão de Produtos
...                  Sendo um administrador de catálogo que possui produtos indesejados
...                  Quero deletar estes produtos
...                  Para que eu possa manter meu catálogo atualizado
Resource             ../resources/actions.robot

Suite Setup           Login session
Suite Teardown        Close session

Test Teardown         After Test


*** Test Cases ***
Apagar produto
    [tags]    smoke
    Dado que eu tenho o produto "mario.json" no catálogo
    Quando solicito a exclusão
    E confirmo a solicitação
    Então não devo ver este item no catálogo

Desistir da remoção
    [tags]    smoke
    Dado que eu tenho o produto "zelda.json" no catálogo
    Quando solicito a exclusão
    Mas cancelo a solicitação
    Então visualizo este item no catálogo