*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    RequestsLibrary
Library    ../libraries/DateTimeLibrary.py
Resource   ../locators/Feed_Page.resource
Library    ../libraries/CustomExcelLibrary.py
Resource    Utility_Step.resource
*** Variables ***
${DATA_DIR}    ${CURDIR}/../data
${EXCEL_PATH}    ${DATA_DIR}/news.xlsx
${CHART_PATH}    ${DATA_DIR}/chart.xlsx


*** Keywords ***
Get birthday
    ${birth_name_elements}=    Get WebElements    ${user_birth_name}
    ${list_birth_name}    Create List
        FOR    ${element}    IN    @{birth_name_elements}
            ${name}    Get Text    ${element}
            Append To List    ${list_birth_name}    ${name}
        END
    ${birth_date_elements}=    Get WebElements    ${user_birth_date}
    ${list_birth_date}    Create List
        FOR    ${element}    IN    @{birth_date_elements}
            ${date}    Get Text    ${element}
            Append To List    ${list_birth_date}    ${date}
        END
        
    ${birth_dict}    Create Dictionary
    ${len}    Get Length     ${list_birth_name}
        FOR    ${index}    IN RANGE    0    ${len}
            ${name}    Set Variable    ${list_birth_name}[${index}]
            ${date}    Set Variable    ${list_birth_date}[${index}]
            Set To Dictionary    ${birth_dict}    ${name}=${date}
        END
    Log    ${birth_dict}

Get news
    [Arguments]    ${element_title}    ${sheet_name}
    ${title}    Get WebElements    ${element_title}
    ${list_title}    Create List
    FOR    ${element}    IN    @{title}
        ${name}    Get Text    ${element}
        Append To List    ${list_title}    ${name}
    END
    ${news}    Split list    ${list_title}    10
    Write Data To Excel    ${EXCEL_PATH}    ${sheet_name}    ${news}
    ${test}    Set Variable    ${EXCEL_PATH}
    Log    ${test}

# Count keyword
#     [Arguments]    ${keyword}
#     ${count}    Count Keyword    ${EXCEL_PATH}    ${keyword}

Create announcement to all employees
    Create driver
    Login to intranet with uid    uid_1
    Navigate to create announcement page
    Send Message To User    All employees
    Log out   

Select action post
    [Arguments]    ${action_post}
    ${action_post_locator}    Replace String    ${action_post_locator}    {action_post}    ${action_post}
    Wait Until Element Is Visible    ${action_post_locator}    10s
    Click Element    ${action_post_locator}

Edit post
    ${str_random}    Get Random String
    Set Suite Variable    ${message_on_feed}    ${str_random}
    Wait Until Element Is Visible    ${action_post_menu_locator}    10s
    Click Element    ${action_post_menu_locator}
    Select action post    Edit
    Input Text To Iframe    ${message_on_feed}
    Sleep    1s
    Click Element    ${send_button_locator}

Comment on post
    Wait Until Element Is Visible    ${comment_locator}    10s
    Click Element    ${comment_locator}
    ${str_random}    Get Random String
    Input Text To Iframe    ${str_random}
    Sleep    1s
    Click Element    ${comment_button_locator}
    Sleep    1s

Like post
    Wait Until Element Is Visible    ${like_locator}    10s
    Click Element    ${like_locator}

Count common keywords
    ${result}    Find Most Common Keywords       ${EXCEL_PATH}
    Log    ${result}
     
Export chart
    ${result}    Find Most Common Keywords       ${EXCEL_PATH}
    Log    ${result}
    ${today}    Get Today  
    ${str_random}    Get Random String
    ${sheet_name}    Set Variable    ${today}_${str_random}
    Save Keywords To Existing Excel    ${CHART_PATH}    ${result}    ${sheet_name}    


Send Message To User 
    [Documentation]    Check user can create message on feed
    [Arguments]    ${user_name}
    ${str_random}    Get Random String
    Set Suite Variable    ${message_on_feed}    ${str_random}
    Input Text To Iframe    ${message_on_feed}
    Select User From Dropdown    ${tag_user_locator}    ${user_name}
    Click Element    ${send_button_locator}
    Sleep    2s

Input Text To Iframe
    [Arguments]    ${text}
    Select Frame    ${iframe_locator}
    Clear Element Text    ${text_locator}
    Input Text    ${text_locator}    ${text}
    Unselect Frame
   
Check Message Appear On Feed
    [Arguments]    ${message_on_feed}
    ${feed_post_text_locator}    Replace String    ${feed_post_text_locator}    {text}    ${message_on_feed}
    Wait Until Element Is Visible    ${feed_post_text_locator}    10s

Check Announcement Appear On Feed
    [Arguments]    ${announcement_text}
    ${announcement_receive_text_locator}    Replace String    ${announcement_receive_text_locator}    {text}    ${announcement_text}
    Wait Until Element Is Visible    ${announcement_receive_text_locator}    10s

Search post by keyword
    [Arguments]    ${keyword}    ${type_sort}
    Input Text    ${search_input_locator}    ${keyword}
    Sleep    1s
    ${type_sort_locator}    Replace String    ${type_sort_locator}    {type_sort}    ${type_sort}
    Wait Until Element Is Visible    ${sort_popup_locator}    10s
    Click Element    ${type_sort_locator}
    # Press Keys    ${search_input_locator}    ENTER
    ${feed_post_text_locator}    Replace String    ${feed_post_text_locator}    {text}    ${keyword}
    Wait Until Element Is Visible    ${feed_post_text_locator}    10s
    
Select User From Dropdown
    [Arguments]    ${dropdown_locator}    ${user_name}    ${timeout}=10
    [Documentation]    Selects a user from a dropdown list
    ...    dropdown_locator: The locator of the dropdown element
    ...    user_name: The name of the user to select
    ...    timeout: Maximum time to wait for elements
    Wait Until Element Is Visible    ${dropdown_locator}    ${timeout}
    Click Element    ${dropdown_locator}
    Sleep    1
    ${user_option}    Set Variable    xpath://div[contains(@class, 'popup-window')]//div[contains(@class, 'popup-window-content')]//div[contains(text(), '${user_name}')]
    Wait Until Element Is Visible    ${user_option}    ${timeout}
    Click Element    ${user_option}
    Sleep    1

Select User From Dropdown With Search
    [Arguments]    ${dropdown_locator}    ${search_input_locator}    ${user_name}    ${timeout}=10
    [Documentation]    Selects a user from a dropdown list with search functionality
    ...    dropdown_locator: The locator of the dropdown element
    ...    search_input_locator: The locator of the search input field
    ...    user_name: The name of the user to select
    ...    timeout: Maximum time to wait for elements
    Wait Until Element Is Visible    ${dropdown_locator}    ${timeout}
    Click Element    ${dropdown_locator}
    Sleep    1
    Wait Until Element Is Visible    ${search_input_locator}    ${timeout}
    Input Text    ${search_input_locator}    ${user_name}
    Sleep    1
    ${user_option}    Set Variable    xpath://div[contains(@class, 'popup-window')]//div[contains(@class, 'popup-window-content')]//div[contains(text(), '${user_name}')]
    Wait Until Element Is Visible    ${user_option}    ${timeout}
    Click Element    ${user_option}
    Sleep    1    