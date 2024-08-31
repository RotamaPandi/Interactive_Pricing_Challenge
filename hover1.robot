*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}    Chrome
${URL}    http://localhost:5173/

*** Test Cases ***
Hover States For Interactive Elements
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    ${elements} =  Get Webelements    //button[normalize-space()='Start my trial']
    FOR    ${element}    IN    @{elements}
    Mouse Over    ${element}
        Log    ${element}    
    ${styles} =    Get Element Attribute    ${element}    class
    Should Contain    ${styles}    sc-euGpHm hhpEpM
    END