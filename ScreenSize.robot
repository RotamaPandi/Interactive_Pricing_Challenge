*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://localhost:5173/
${MOBILE_WIDTH}  412
${MOBILE_HEIGHT}  915
${TABLET_WIDTH}  768
${TABLET_HEIGHT}  1024
${DESKTOP_WIDTH}  1280
${DESKTOP_HEIGHT}  800 

*** Keywords ***
Open App On Desktop Device
    Open Browser    ${URL}    Chrome
    Set Window Size    ${DESKTOP_WIDTH}    ${DESKTOP_HEIGHT}

Open App On Tablet Device
    Open Browser    ${URL}    Chrome
    Set Window Size    ${TABLET_WIDTH}    ${TABLET_HEIGHT}

Open App On Mobile Device
    Open Browser    ${URL}    Chrome
    Set Window Size    ${MOBILE_WIDTH}    ${MOBILE_HEIGHT}

Verify Layout and Elements Aligned To Screen Size
    Wait Until Page Contains    Simple, traffic-based pricing
    Wait Until Page Contains    Sign-up for our 30-day trial. No credit card required.    
    Element Should Be Visible    //div[@class='sc-gLXSEc gdYgtW']
    Element Should Be Visible    //div[@class='sc-dorvvM kElNoy']
    Capture Page Screenshot

Set Viewport To Portrait On Desktop Device
    Set Window Size    ${DESKTOP_HEIGHT}    ${DESKTOP_WIDTH}

Set Viewport To Portrait On Tablet Device
    Set Window Size    ${TABLET_HEIGHT}    ${TABLET_WIDTH}

Set Viewport To Portrait On Mobile Device
    Set Window Size    ${MOBILE_HEIGHT}    ${MOBILE_WIDTH}

Run Layout Tests
    Element Should Be Visible    //*[@id="root"]
    ${header_size}=    Get Element Size    //*[@id="root"]
    ${header_width}=    Set Variable    ${header_size}[0]
    ${header_height}=    Set Variable    ${header_size}[1]
    Should Be True    ${header_width} > 0
    Should Be True    ${header_height} > 0

*** Test Cases ***
Verify Layout On Desktop Screen Size
    Open App On Desktop Device
    Verify Layout and Elements Aligned To Screen Size
    Run Layout Tests
    Set Viewport To Portrait On Desktop Device
    Verify Layout and Elements Aligned To Screen Size
    Run Layout Tests
    [Teardown]    Close Browser

Verify Layout On Tablet Screen Size
    Open App On Tablet Device
    Verify Layout and Elements Aligned To Screen Size
    Run Layout Tests
    Set Viewport To Portrait On Tablet Device
    Verify Layout and Elements Aligned To Screen Size
    Run Layout Tests
    [Teardown]    Close Browser

Verify Layout On Mobile Screen Size
    Open App On Mobile Device
    Verify Layout and Elements Aligned To Screen Size
    Run Layout Tests
    Set Viewport To Portrait On Mobile Device
    Verify Layout and Elements Aligned To Screen Size
    Run Layout Tests
    [Teardown]    Close Browser