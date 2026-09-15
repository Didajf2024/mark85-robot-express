*** Settings ***
Documentation           Cenários de autenticação do usuário

Library             Collections
Resource            ../resource/base.resource

Test Stup           Start Session
Test Teardown       Take Screenshot

*** Test Cases ***

Deve poder logar com um usuário pré-cadastrado

    ${user}     Create Dictionary
    ...     name=Fernando Papito
    ...     email=papito@msn.com
    ...     password=123456

    Remove user from database   ${user}[email]
    Insert user from database   ${user}

    Submit logim form           ${user}
    User should be logged in    ${user}[name]


Não deve logar com senha inválida

    ${user}     Create Dictionary
    ...     name=Steve Woz
    ...     email=woz@apple.com
    ...     password=123456

    Remove user from database   ${user}[email]
    Insert user from database   ${user}

    Set To Dictionary       ${user}         password=abc123

    Submit logim form           ${user}
    Notice should be            Ocorrei um erro ao fazer login, verifique suas credenciais.