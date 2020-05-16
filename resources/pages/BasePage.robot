*** Settings ***
Documentation    Este arquivo implementa a abertura e fechamento do browser

*** Variables ***
# Padronização: Variaveis sem caps lock não são seletores
${base_url}    http://pixel-web:3000

# Padronização: Variaveis com CAPS LOCK são seletores
${ALERT_DANGER}    class:alert-danger
${ALERT_INFO}      class:alert-info

*** Keywords ***
### Hooks
Open Session

    Run Keyword if    "${browser}" == "chrome"
    ...    Open Chrome

    Run Keyword if    "${browser}" == "headless"
    ...    Open Chrome Headless


    # Open Chrome
    Set Selenium Implicit Wait    5
    Set Window Size               1280        800

Close Session
    Close Browser

After Test
    Capture Page Screenshot

After Test WCLS
    Capture Page Screenshot
    Execute Javascript        localStorage.clear();

# After Test Tentative Create Product
#     Capture Page Screenshot
#     Execute Javascript    window.location.reload(true);

Login Session
    Open session
    Login with    didico@ninjapixel.com    pwd123

Product Form Session
    Login session
    Go To Product Form

Tentative Create Product
    Go To Create Product
    Go To Product Form

Open Chrome
    Open Browser    ${base_url}/login    chrome    options=add_experimental_option('excludeSwitches', ['enable-logging'])


Open Chrome Headless
    Open Browser    ${base_url}/login    headlesschrome    options=add_argument('--disable-dev-shm-usage')