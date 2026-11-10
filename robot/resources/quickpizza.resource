*** Settings ***
Documentation    Locators and actions for the QuickPizza pages visited by QP-01.
Library          SeleniumLibrary    timeout=10s

*** Variables ***
${URL}                https://quickpizza.grafana.com
${BROWSER}            chrome
${HEADING}            Looking to break out of your pizza routine?

*** Keywords ***
Open QuickPizza
    Open Browser    ${URL}    ${BROWSER}    service=executable_path=r'%{CHROMEDRIVER}'
    Set Window Size    1280    1600
    Wait Until Element Is Visible    css:h1
    Element Text Should Be    css:h1    ${HEADING}
