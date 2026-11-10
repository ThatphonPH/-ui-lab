*** Settings ***
Library          SeleniumLibrary
Test Teardown    Close Browser

*** Variables ***
${URL}               https://www.selenium.dev/selenium/web/web-form.html
${BROWSER}           chrome
${EXPECTED TITLE}    Web form

*** Test Cases ***
The Web Form Opens
    [Documentation]    Open the Selenium web form and verify its title.
    Open Browser    ${URL}    ${BROWSER}    service=executable_path=r'%{CHROMEDRIVER}'
    Title Should Be    ${EXPECTED TITLE}
