*** Settings ***
Documentation    Actions é o arquivo que terá keywords que implementam os steps

Library    libs/db.py
Library    SeleniumLibrary
# Biblioteca que serve para fazer a conversão no json
Library    OperatingSystem
# Pages que nos ajudam a organizar melhor o projeto e manutenção
Resource    pages/LoginPage.robot
Resource    pages/BasePage.robot
Resource    pages/Sidebar.robot
Resource    pages/ProductPage.robot
Resource    pages/GetProductPage.robot

*** Keywords ***
## Login ###
Dado que eu acesso a página de login
    Go To    ${base_url}/login

Quando solicito submeto minhas credenciais de login "${email}" e senha "${senha}"
    Login with    ${email}    ${senha}

Então visualizo o nome do usuário "${nome}" no dashboard
    Wait Until Element Is Visible    ${LOGGED_USER}
    Wait Until Element Contains      ${LOGGED_USER}    ${nome}
    Element Text Should Be           ${LOGGED_USER}    ${nome}

Então devo ver uma mensagem de erro
    [Arguments]        ${expect_message}
    Wait Until Element Contains      ${ALERT_DANGER}    ${expect_message}
    Element Text Should Be           ${ALERT_DANGER}    ${expect_message}
    
Então devo ver uma mensagem informativa
    [Arguments]        ${expect_message}
    Wait Until Element Contains      ${ALERT_INFO}    ${expect_message}
    Element Text Should Be           ${ALERT_INFO}    ${expect_message}


## Product ##
Dado que eu tenho um novo produto
    [Arguments]    ${file_name}

    ${product_json}=      Get Product Json        ${file_name}      

    Remove Product By Name    ${product_json['name']}
    Set Test Variable     ${product_json}

Mas este produto já foi cadastrado
    Go To Product Form
    Create New Product    ${product_json}

Quando eu faço o cadastro desse produto
    Go To Product Form
    Create New Product    ${product_json}

Quando eu tento cadastrar o produto
    Create New Product    ${product_json}

Então visualizo este item no catálogo
    # Então no BDD é o Checkpoint
    Table Should Contain    class:table    ${product_json['name']}


## Remover ##
Dado que eu tenho o produto "${file_name}" no catálogo
    # Aqui estamos criando um produto destinado a ser removido
    ${product_json}=      Get Product Json        ${file_name}      

    Remove Product By Name    ${product_json['name']}

    Go To Product Form
    Create New Product    ${product_json}

    Set Test Variable     ${product_json}

Quando solicito a exclusão
    Click Element                    xpath://tr[td//text()[contains(., '${product_json['name']}')]]//button
    Wait Until Element Is Visible    class:swal2-modal    

E confirmo a solicitação
    Click Element        class:swal2-confirm

Mas cancelo a solicitação
    Click Element        class:swal2-cancel

Então não devo ver este item no catálogo
    Wait Until Element Does Not Contain    class:table    ${product_json['name']}
