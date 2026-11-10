*** Settings ***
Resource         resources/quickpizza.resource
Test Teardown    Close Browser

*** Test Cases ***
QP-01 A Custom Pizza Reaches The Admin List
    [Documentation]    Check pizza restrictions, the anonymous rating prompt, and the admin list.
    # Step 1
    Open QuickPizza
