*** Settings ***
Documentation    Locators and actions for the QuickPizza pages visited by QP-01.
Library          SeleniumLibrary    timeout=10s

*** Variables ***
${URL}                https://quickpizza.grafana.com
${BROWSER}            chrome
${HEADING}            Looking to break out of your pizza routine?
${MAX CALORIES}       xpath://label[normalize-space()='Max Calories per Slice']/preceding-sibling::input
${EXCLUDED TOOLS}     css:select
${VEGETARIAN}         id:default-checkbox
${PIZZA NAME}         css:input#pizza-name

*** Keywords ***
Open QuickPizza
    Open Browser    ${URL}    ${BROWSER}    service=executable_path=r'%{CHROMEDRIVER}'
    Set Window Size    1280    1600
    Wait Until Element Is Visible    css:h1
    Element Text Should Be    css:h1    ${HEADING}

Turn On Advanced
    Click Element    xpath://label[.//span[normalize-space()='Advanced']]
    Wait Until Page Contains Element    xpath://select/option[normalize-space()='Knife']
    Element Should Be Visible    ${MAX CALORIES}
    Element Should Be Visible    ${EXCLUDED TOOLS}
    Element Should Be Visible    ${VEGETARIAN}
    Element Should Be Visible    ${PIZZA NAME}

Fill In The Pizza Request
    [Arguments]    ${calories}    ${tool}    ${name}
    Input Text    ${MAX CALORIES}    ${calories}
    Select From List By Label    ${EXCLUDED TOOLS}    ${tool}
    Select Checkbox    ${VEGETARIAN}
    Input Text    ${PIZZA NAME}    ${name}
    Textfield Value Should Be    ${MAX CALORIES}    ${calories}
    List Selection Should Be    ${EXCLUDED TOOLS}    ${tool}
    Checkbox Should Be Selected    ${VEGETARIAN}
    Textfield Value Should Be    ${PIZZA NAME}    ${name}
