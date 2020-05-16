

***Variables***
${var}=      Papito      

***Test Cases***
Testando if e else
    Run Keyword If    "${var}" == "Papito"    Log To Console    "Teste com sucesso"
    Run Keyword If    "${var}" != "Papito"    Log To Console    "Teste com insucesso"

    # Run Keyword If    "${var}" == "Papito"    Run Keywords
    # Run Keyword If    "${var}" != "Papito"    Run Keywords
    
    # ${var}=    Set Variable if
    # ...      "${var}"=="teste"     Log To Console    ${var}
    # ...      "${var}"=="papito"    Log To Console    ${var}   
