
*** Keywords ***
Get Product Json
    [Arguments]     ${file_name}

    ${file}=    Get File    resources/fixtures/${file_name}
    ${json}=    Evaluate    json.loads($file)          json

    [return]    ${json}