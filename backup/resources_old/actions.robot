*** Settings ***
Documentation    Resource é o arquivo para ter o controle das interações e validações
...              Semelhante ao Page Object para estruturar a base de utilização dos
...              keywords do Robot Framework

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

# *** Variables ***
# ${URL}    http://pixel-web:3000



*** Keywords ***
# Nova sessão
#    Open Browser    ${URL}    chrome

# Encerrar sessão
#    Capture Page Screenshot
#    Close Browser

# Login with
#    [Arguments]      ${username}                   ${password}
#    Input Text       id:emailId                    ${username}
#    Input Text       css:input[name='password']    ${password}
#    Click Element    class:btn-round

# Apresentar o nome do usuário
#    [Arguments]                 ${nome}
#    Wait Until Page Contains    ${nome}

# Apresentar mensagem de alerta
#    [Arguments]                 ${expect_message}
#    Wait Until Page Contains    ${expect_message}
#    ${message}=                 Get WebElement       class:alert          #class:alert-info
#    Should Contain              ${message.text}      ${expect_message}

# Apresentar mensagem de erro
#    [Arguments]                    ${expect_message}
#    # Wait Until Page Contains     ${expect_message}
#    # ${message}=                  Get WebElement        class:alert-danger
#    Wait Until Element Contains    class:alert-danger    ${expect_message}


### Helpers
# Get Product Json
#     [Arguments]    ${file_name}

#     ${file}=        Get File    resources/fixtures/${file_name}
#     ${json}=        Evaluate    json.loads($file)          json

#     [Return]        ${json}

# Clear Local Storage
#     Execute Javascript        localStorange.clear();

## Login ###

Dado que eu acesso a página de login
    Go To    ${base_url}/login
    # Open Chrome

Quando solicito submeto minhas credenciais de login "${email}" e senha "${senha}"
    # LoginPage.Login with    ${email}    ${senha}
    Login with    ${email}    ${senha}

Então visualizo o nome do usuário "${nome}" no dashboard
    # Wait Until Page Contains     ${nome}
    Wait Until Element Is Visible    ${LOGGED_USER}
    Wait Until Element Contains      ${LOGGED_USER}    ${nome}
    Element Text Should Be           ${LOGGED_USER}    ${nome}

# Então visulizo uma mensagem de alerta "${mensagem}"
#     Wait Until Element Contains    class:alert    ${mensagem}

Então devo ver a mensagem de erro
    [Arguments]        ${expect_message}
    Wait Until Element Contains      ${ALERT_DANGER}    ${expect_message}
    Element Text Should Be           ${ALERT_DANGER}    ${expect_message}
    
Então devo ver a mensagem informativa
    [Arguments]        ${expect_message}
    Wait Until Element Contains      ${ALERT_INFO}    ${expect_message}
    Element Text Should Be           ${ALERT_INFO}    ${expect_message}



## Product ##

# Dado que eu estou logado
#     Login with    didico@ninjapixel.com    pwd123

Dado que eu tenho um novo produto
    [Arguments]    ${file_name}

    # ${file}=            Get File    resources/fixtures/${file_name}
    # ${product_json}=    Evaluate    json.loads($file)          json
    ${product_json}=      Get Product Json        ${file_name}      

    Remove Product By Name    ${product_json['name']}
    Set Test Variable     ${product_json}

Mas este produto já foi cadastrado
    Go To Product Form
    Create New Product    ${product_json}

Quando eu faço o cadastro desse produto
    # [Arguments]    ${json_file}

    # ${product_file}=    Get File    resources/fixtures/${json_file}
    # ${product_json}=    Evaluate    json.loads($product_file)          json

    # Remove Product By Name    ${product_json['name']}
    Go To Product Form

    Create New Product    ${product_json}
    # Set Test Variable     ${product_json}

Quando eu tento cadastrar o produto
    Create New Product    ${product_json}

Então visualizo este item no catálogo
    # Então no BDD é o Checkpoint
    Table Should Contain    class:table    ${product_json['name']}

# Então devo ver a mensagem de erro
#     [Arguments]        ${expect_message}
#     Wait Until Element Contains      class:alert-danger    ${expect_message}
#     Element Text Should Be           class:alert-danger    ${expect_message}
#     Click Element                    ${CREATE}
    
# Então devo ver a mensagem informativa
#     [Arguments]        ${expect_message}
#     Wait Until Element Contains      class:alert-info    ${expect_message}
#     Element Text Should Be           class:alert-info    ${expect_message}
#     Click Element                    ${CREATE}


## Remover ##

Dado que eu tenho o produto "${file_name}" no catálogo
    # Aqui estamos criando um produto destinado a ser removido
    # Dado que eu tenho um novo produto    ${file_name}

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

Então não devo ver este item no catálogo
    Wait Until Element Does Not Contain    class:table    ${product_json['name']}

Mas cancelo a solicitação
    Click Element        class:swal2-cancel