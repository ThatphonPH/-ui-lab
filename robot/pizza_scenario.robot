*** Settings ***
Resource         resources/quickpizza.resource
Library          DateTime
Test Teardown    Close Browser

*** Test Cases ***
QP-01 A Custom Pizza Reaches The Admin List
    [Documentation]    Check pizza restrictions, the anonymous rating prompt, and the admin list.
    # Step 1
    Open QuickPizza
    # Step 2
    Turn On Advanced
    # Step 3
    ${stamp}=    Get Current Date    result_format=%Y%m%d-%H%M%S
    ${name}=    Set Variable    Lab Pizza ${stamp}
    Fill In The Pizza Request    600    Knife    ${name}
    Capture Page Screenshot    qp01-step3-fields.png
    # Step 4
    Ask For A Pizza
    ${tool}=    Recommendation Should Keep The Restrictions    ${name}    Knife    600
    Capture Element Screenshot    ${RECOMMENDATIONS}    qp01-step4-pizza.png
