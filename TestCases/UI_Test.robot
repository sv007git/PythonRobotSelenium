*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${URL}            http://www.google.com
${Browser}        Chrome

*** Keywords ***
Launch Browser
        [Documentation]     Opens the browser
        [Arguments]         ${URL}     ${Browser}
        open browser        ${URL}    ${Browser}
        maximize browser window

*** Test Cases ***

TC 1
    Launch Browser          ${URL}       ${Browser}
