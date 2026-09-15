*** Settings ***

Documentation           Consumiondo a API REST do sistema Mark85

Library         RequestyLibrary

*** Keywords ***

POST new session
    [Arguments]         ${user}

    ${payload}          Create Dictionary
    ...         email=${user}[email]
    ...         password=${user}[password]

   ${resp}      POST        url=http://localhost:3333/sessions
    ...         json=${payload}
    ...         expected_status=200

   ${token}     Set Variable        ${resp.json()}[token]

   Set Test Variable        ${token}

POST a new task
    [Arguments]         ${payload}

    ${headres}          Create Dictionary
    ...         Autorization=${token}

    POST        url=http://localhost:3333/tasks
    ...         json=${payload}
    ...         headres=${headers}
    ...         expected_status=201