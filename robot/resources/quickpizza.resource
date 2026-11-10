*** Settings ***
Documentation    Locators and actions for the QuickPizza pages visited by QP-01.
Library          SeleniumLibrary    timeout=10s
Library          String

*** Variables ***
${URL}                https://quickpizza.grafana.com
${BROWSER}            chrome
${HEADING}            Looking to break out of your pizza routine?
${MAX CALORIES}       xpath://label[normalize-space()='Max Calories per Slice']/preceding-sibling::input
${EXCLUDED TOOLS}     css:select
${VEGETARIAN}         id:default-checkbox
${PIZZA NAME}         css:input#pizza-name
${RECOMMENDATIONS}    id:recommendations

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

Ask For A Pizza
    Click Button    name:pizza-please
    Wait Until Element Contains    ${RECOMMENDATIONS}    Name:

Get Recommended Tool
    ${line}=    Get Text    xpath://*[@id='recommendations']//p[starts-with(.,'Tool:')]
    ${tool}=    Remove String    ${line}    Tool:${SPACE}
    RETURN    ${tool}

Get Calories Per Slice
    ${line}=    Get Text    xpath://*[@id='recommendations']//p[starts-with(.,'Calories per slice:')]
    ${calories}=    Remove String    ${line}    Calories per slice:${SPACE}
    RETURN    ${calories}

Recommendation Should Keep The Restrictions
    [Arguments]    ${name}    ${excluded tool}    ${max calories}
    Element Should Contain    ${RECOMMENDATIONS}    Name: ${name}
    ${tool}=    Get Recommended Tool
    Should Not Be Empty    ${tool}
    Should Not Be Equal    ${tool}    ${excluded tool}
    ${calories}=    Get Calories Per Slice
    Should Be True    float($calories) <= float($max_calories)
    RETURN    ${tool}

Rate The Pizza Without Logging In
    Click Button    name:rate-5
    Wait Until Element Contains    id:rate-result    Please log in first.

Log In As Admin
    Go To    ${URL}/admin
    Wait Until Page Contains Element    id:svelte-announcer
    # QuickPizza supplies the public demo values in the form and documents them as hints.
    Input Text    id:username    admin
    Input Password    id:password    admin
    Click Button    css:button[type=submit]
    Wait Until Page Contains    Latest pizza recommendations

Admin List Should Show The Pizza
    [Arguments]    ${name}    ${tool}
    ${row}=    Set Variable    xpath://li[contains(.,'${name}')]
    Wait Until Element Is Visible    ${row}
    Element Should Contain    ${row}    (tool=${tool},
