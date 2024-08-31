*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://localhost:5173/
${PAGE_VIEWS_XPATH}  //div[@class='sc-bSlUec jJCukq']
${PRICE_XPATH}       //div[@class='sc-iCZwEW fXCSxI']
${BTC_XPATH}         //span[@class='sc-kkmypM dTBIfo']
${SLIDER_XPATH}      //input[@class='sc-jCbFiK levBCq']
${Toggle_btn}    //div[@role='button']
${Discount_btn}    //span[@aria-label='toggle-slider']

*** Test Cases ***
Verify Slider Value 0 for Monthly Billing
    [Setup]    Open Browser    ${URL}    chrome
    Wait Until Element Is Visible    ${SLIDER_XPATH}
    Sleep    1
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    -200    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    0    10K PAGEVIEWS    $8.00
    Reload Page
Verify Slider Value 25 for Monthly Billing
    Sleep    1
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    -100    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    25    50K PAGEVIEWS    $12.00
    Reload Page
Verify Slider Value 50 for Monthly Billing
    Sleep    1
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    0    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    50    100K PAGEVIEWS    $16.00
    Reload Page
Verify Slider Value 75 for Monthly Billing
    Sleep    1
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    100    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    75    500K PAGEVIEWS    $24.00
    Reload Page
Verify Slider Value 100 for Monthly Billing
    Sleep    1
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    200    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    100    1M PAGEVIEWS    $36.00
    Reload Page
Verify Slider Value 0 for Yearly Billing
    Sleep    1
    # applying a 25% discount on yearly plans
    Wait Until Element Is Visible    ${Discount_btn}
    Click Element    ${Discount_btn}
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    -200    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    0    10K PAGEVIEWS    $6.00
    Reload Page
Verify Slider Value 25 for Yearly Billing
    Sleep    1
    # applying a 25% discount on yearly plans
    Wait Until Element Is Visible    ${Discount_btn}
    Click Element    ${Discount_btn}
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    -100    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    25    50K PAGEVIEWS    $9.00
    Reload Page
Verify Slider Value 50 for Yearly Billing
    Sleep    1
    # applying a 25% discount on yearly plans
    Wait Until Element Is Visible    ${Discount_btn}
    Click Element    ${Discount_btn}
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    0    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    50    100K PAGEVIEWS    $12.00
    Reload Page
Verify Slider Value 75 for Yearly Billing
    Sleep    1
    # applying a 25% discount on yearly plans
    Wait Until Element Is Visible    ${Discount_btn}
    Click Element    ${Discount_btn}
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    100    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    75    500K PAGEVIEWS    $18.00
    Reload Page
Verify Slider Value 100 for Yearly Billing
    Sleep    1
    # applying a 25% discount on yearly plans
    Wait Until Element Is Visible    ${Discount_btn}
    Click Element    ${Discount_btn}
    # Use the slider and toggle to see prices for different page view numbers
    Drag And Drop By Offset    ${Toggle_btn}    200    0
    # Prices are displayed in both USD and BTC
    Check BTC to USD Exchange Rate On UI
    Set And Verify Slider Value    100    1M PAGEVIEWS    $27.00
    [Teardown]    Close Browser

*** Keywords ***
Set And Verify Slider Value
    [Arguments]    ${value}    ${expected_page_views}    ${expected_price}
    Wait Until Element Is Visible    ${PAGE_VIEWS_XPATH}
    ${actual_page_views}=    Get Text    ${PAGE_VIEWS_XPATH}
    Wait Until Element Is Visible    ${PRICE_XPATH}
    ${actual_price}=    Get Text    ${PRICE_XPATH}
    Should Be Equal    ${actual_page_views}    ${expected_page_views}
    Should Be Equal    ${actual_price}    ${expected_price}

Check BTC to USD Exchange Rate On UI
    ${exchange_rate}=    Get Text    ${BTC_XPATH}
    Log    BTC to USD Exchange Rate: ${exchange_rate}
    
    # Convert to float and perform validation if necessary
    ${rate}=    Evaluate    float('${exchange_rate}'.replace('BTC', '').replace('$', '').replace(',', '').strip())
    Should Be True    ${rate} > 0    The BTC to USD exchange rate should be greater than 0.