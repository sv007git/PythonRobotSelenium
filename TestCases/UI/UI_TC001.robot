*** Settings ***

Library     SeleniumLibrary

*** Test Cases ***

TC
    Launch Browser          http://www.google.com       Chrome

*** Keywords ***
Launch Browser
        [Documentation]     Opens the browser
        [Arguments]     ${URL}     ${Browser}
        open browser  ${URL}    ${Browser}
        maximize browser window
