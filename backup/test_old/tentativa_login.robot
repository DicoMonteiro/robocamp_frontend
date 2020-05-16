*** Settings ***
Documentation       Suite de testes para validar o login do sistema Pixel
...                 Sendo um administrador de catálogo
...                 Quero me autenticar no sistema
...                 Para que eu possa gerenciar o catálogo de produtos

Resource             ../resources/actions.robot

Suite Setup           Open Session
Suite Teardown        Close Session

Test Setup            Reload Page
Test Teardown         After Test


*** Test Cases ***
Login com senha inválida
    [tags]    smoke
    [Template]    Tentativa de login com mensagem de erro
    didico@ninjapixel.com    teste123    Usuário e/ou senha inválidos

Login com email inválido
    [tags]    smoke
    [Template]    Tentativa de login com mensagem de erro
    teste@ninjapixel.com    pwd123    Usuário e/ou senha inválidos

Login com senha branco
    [tags]    smoke
    [Template]    Tentativa de login com mensagem informativa
    didico@ninjapixel.com    ${EMPTY}    Opps. Informe a sua senha!

Login com email branco
    [tags]    smoke
    [Template]    Tentativa de login com mensagem informativa
    ${EMPTY}     pwd123    Opps. Informe o seu email!


*** Keywords ***
Tentativa de login com mensagem de erro
    [Arguments]      ${email}    ${senha}    ${mensagem}

    Dado que eu acesso a página de login
    Quando solicito submeto minhas credenciais de login "${email}" e senha "${senha}"
    Então devo ver a mensagem de erro     ${mensagem}

Tentativa de login com mensagem informativa
    [Arguments]      ${email}    ${senha}    ${mensagem}

    Dado que eu acesso a página de login
    Quando solicito submeto minhas credenciais de login "${email}" e senha "${senha}"
    Então devo ver a mensagem informativa     ${mensagem}

