*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    RequestsLibrary
Resource    ../locators/Login_Page.resource
Resource    ../locators/Feed_Page.resource
Resource    ../environment/Environment.resource
Resource    ../steps/Feed_Step.resource
Resource    ../locators/Chat_And_Call_Page.resource
Library    ../libraries/CustomExcelLibrary.py

*** Keywords ***
Create driver
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
        Call Method  ${options}  add_argument  --disable-notifications
        Call Method  ${options}  add_argument  --disable-infobars
        Call Method  ${options}  add_argument  --disable-extensions
        Call Method  ${options}  add_argument  --no-sandbox
        Call Method  ${options}  add_argument  --headless
        Call Method  ${options}  add_argument  --disable-dev-shm-usage
        Call Method  ${options}  add_argument  --start-maximized
    Create Webdriver    Chrome    options=${options}
    # Maximize Browser Window

Navigate to login page
    [Arguments]    ${url}
    Go To    ${url}
    
Login with username and password 
    [Arguments]    ${username}    ${password}
    Input Text    ${user_name_selector}    ${username}
    Sleep    1
    Input Text    ${password_selector}    ${password}
    Sleep    1
    Click Button    ${submit_button_selector}
          
Login to intranet with uid
    [Arguments]    ${uid}
    Create driver
    Go to    ${BASE_URL} 
    ${data_path}    Join Path    ${CURDIR}    ../data/data.xlsx
    ${account}    Get account by uid    ${data_path}    ${uid}
    ${username}    Get From List    ${account}    2
    ${password}    Get From List    ${account}    3
    Login with username and password    ${username}    ${password}
    Sleep    2

Log out
    Click Element    ${profile_locator}
    Click Element    ${logout_locator}

Admin log out
    Click Element    ${admin_logout_locator}

Navigate to create channel page
    Wait Until Element Is Visible    ${channel_menu_locator}    10s
    Click Element    ${channel_menu_locator}
    Wait Until Element Is Visible    ${channel_locator}    10s
    Click Element    ${channel_locator}    
    Wait Until Element Is Visible    ${create_channel_locator}    10s
    Click Element    ${create_channel_locator}

Navigate to list channel    
    Wait Until Element Is Visible    ${channel_menu_locator}    10s
    Click Element    ${channel_menu_locator}
    Wait Until Element Is Visible    ${channel_locator}    10s
    Click Element    ${channel_locator}       

Navigate to create event page
    Click Element    ${calendar}
    Click Element    ${create_event}

Navigate to create message page
    Go to    ${BASE_URL}/stream
    Click Element    ${message_locator}

Navigate to create announcement page
    Wait Until Element Is Visible    ${more_post_locator}    10s
    Click Element    ${more_post_locator}
    Wait Until Element Is Visible    ${announcement_locator}    10s
    Click Element    ${announcement_locator}

Close Browser And Clean Session
    [Documentation]    Closes browser and cleans up session
    Close All Browsers
    Sleep    1
    ${status}    ${value}=    Run Keyword And Ignore Error    Execute JavaScript    window.localStorage.clear()
    ${status}    ${value}=    Run Keyword And Ignore Error    Execute JavaScript    window.sessionStorage.clear()
    Sleep    1

Clean Session
    [Documentation]    Cleans up session
    ${status}    ${value}=    Run Keyword And Ignore Error    Execute JavaScript    window.localStorage.clear()
    ${status}    ${value}=    Run Keyword And Ignore Error    Execute JavaScript    window.sessionStorage.clear()
    Sleep    1s

# Click Element Safely
#     [Arguments]    ${locator}    ${timeout}=10
#     [Documentation]    Safely clicks an element by scrolling it into view and using JavaScript if needed
#     ...    locator: The element locator
#     ...    timeout: Maximum time to wait for element
#     Wait Until Element Is Visible    ${locator}    ${timeout}
#     Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
#     Sleep    1
#     Execute JavaScript    document.evaluate('${locator}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({block: 'center', behavior: 'smooth'})
#     Sleep    2
#     ${status}    ${value}=    Run Keyword And Ignore Error    Click Element    ${locator}
#     Run Keyword If    '${status}' == 'FAIL'    
#     ...    Execute JavaScript    document.evaluate('${locator}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click()
#     Sleep    1

# Scroll Element Into View
#     [Arguments]    ${locator}    ${timeout}=10
#     [Documentation]    Scrolls an element into view
#     ...    locator: The element locator
#     ...    timeout: Maximum time to wait for element
#     Wait Until Element Is Visible    ${locator}    ${timeout}
#     Execute JavaScript    document.evaluate('${locator}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView({block: 'center'})
#     Sleep    1

# Select User From Dropdown
#     [Arguments]    ${dropdown_locator}    ${user_name}    ${timeout}=10
#     [Documentation]    Selects a user from a dropdown list
#     ...    dropdown_locator: The locator of the dropdown element
#     ...    user_name: The name of the user to select
#     ...    timeout: Maximum time to wait for elements
#     Wait Until Element Is Visible    ${dropdown_locator}    ${timeout}
#     Click Element    ${dropdown_locator}
#     Sleep    1
#     ${user_option}    Set Variable    xpath://div[contains(@class, 'popup-window')]//div[contains(@class, 'popup-window-content')]//div[contains(text(), '${user_name}')]
#     Wait Until Element Is Visible    ${user_option}    ${timeout}
#     Click Element    ${user_option}
#     Sleep    1

# Select User From Dropdown With Search
#     [Arguments]    ${dropdown_locator}    ${search_input_locator}    ${user_name}    ${timeout}=10
#     [Documentation]    Selects a user from a dropdown list with search functionality
#     ...    dropdown_locator: The locator of the dropdown element
#     ...    search_input_locator: The locator of the search input field
#     ...    user_name: The name of the user to select
#     ...    timeout: Maximum time to wait for elements
#     Wait Until Element Is Visible    ${dropdown_locator}    ${timeout}
#     Click Element    ${dropdown_locator}
#     Sleep    1
#     Wait Until Element Is Visible    ${search_input_locator}    ${timeout}
#     Input Text    ${search_input_locator}    ${user_name}
#     Sleep    1
#     ${user_option}    Set Variable    xpath://div[contains(@class, 'popup-window')]//div[contains(@class, 'popup-window-content')]//div[contains(text(), '${user_name}')]
#     Wait Until Element Is Visible    ${user_option}    ${timeout}
#     Click Element    ${user_option}
#     Sleep    1



        

    
         





        



    
