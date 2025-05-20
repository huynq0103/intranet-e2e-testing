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
Resource    Utility_Step.resource
Library    ../libraries/CustomExcelLibrary.py

*** Keywords ***
Admin Create Channel
    [Arguments]    ${channel_type}    ${user_name}
    Create driver
    Login to intranet with uid    uid_1
    Navigate to create channel page

Create Channel 
    [Arguments]    ${creator}    ${channel_type}    ${user_name}
    Run Keyword If    '${creator}' == 'uid_1'    
    ...    Admin Create Channel    ${channel_type}    ${user_name}
    ${text_random}    Get Random String
    Set Suite Variable    ${channel_name}    ${text_random}
    Input Text    ${channel_name_locator}    ${channel_name}
    Sleep    1s
    Input Text    ${channel_description_locator}    ${text_random}
    Sleep    1s
    ${channel_type_locator}    Replace String    ${channel_type_locator}    {channel_type}    ${channel_type}
    Click Element    ${channel_type_locator}
    Sleep    1s
    Run Keyword If    '${user_name}' != 'None'    
    ...    Select User From Dropdown    ${tag_user_channel_locator}    ${user_name}
    Click Element    ${create_channel_button_locator}
    Sleep    2s
   #  Admin log out
Create Channel With Type And Member 
    [Arguments]    ${creator}    ${channel_type}    ${user_name}    ${retry_count}=3    ${retry_interval}=2s
    [Documentation]    Retries the Create Channel With Type And User keyword if it fails
    ...    channel_type: Type of channel to create
    ...    user_name: Name of user to add to channel
    ...    retry_count: Number of retry attempts
    ...    retry_interval: Time to wait between retries
    Wait Until Keyword Succeeds    ${retry_count}x    ${retry_interval}    Create Channel     ${creator}    ${channel_type}    ${user_name}

Check Channel Appear On List
    [Arguments]    ${channel_name}
    ${channel_title_locator}    Replace String    ${channel_title_locator}    {channel_name}    ${channel_name}
    Wait Until Element Is Visible    ${channel_title_locator}    10s

Check Channel Not Appear On List
    [Arguments]    ${channel_name}
    ${channel_title_locator}    Replace String    ${channel_title_locator}    {channel_name}    ${channel_name}
    Wait Until Element Is Not Visible    ${channel_title_locator}    10s

Add Member To Channel
    [Arguments]    ${user_name}
    Wait Until Element Is Visible    ${add_chat_member_locator}    10s
    Click Element    ${add_chat_member_locator}
    Sleep    2s
    Wait Until Element Is Visible    ${popup_chat_locator}    10s
    Wait Until Element Is Visible    ${recent_chat_locator}    10s
    Click Element    ${recent_chat_locator}
    Sleep    1s
    # Sleep    1s
    # Wait Until Element Is Visible    ${first_recent_search_locator}    15s
    # Mouse Over    ${first_recent_search_locator}
    # Click Element    ${first_recent_search_locator}
    # Sleep    1s
    Select User From Dropdown With Search    ${tag_add_member_channel_locator}    ${input_search_member_chat_locator}    ${user_name}    ${user_option_locator}
    Click Element    ${invite_locator}
    Sleep    2s    
    Admin log out

Click On Channel Title
    [Arguments]    ${channel_name}    ${timeout}=10
    [Documentation]    Clicks on the div containing the channel title span
    ...    channel_name: Name of the channel to click
    ...    timeout: Maximum time to wait for element
    ${div_locator}    Set Variable    //span[text()='${channel_name}']
    Wait Until Element Is Visible    ${div_locator}    ${timeout}
    Mouse Over    ${div_locator}
    Click Element    ${div_locator}
    Sleep    1s

Check member was added to channel
    [Arguments]    ${channel_name}    ${user_name}
    Click On Channel Title    ${channel_name}
    Wait Until Element Is Visible    ${view_member_locator}    10s
    Click Element    ${view_member_locator}
    ${member_name_locator}    Replace String    ${member_name_locator}    {user_name}    ${user_name}
    Wait Until Element Is Visible    ${member_name_locator}    10s

Search Channel
    [Arguments]    ${channel_name}
    Wait Until Element Is Visible    ${search_channel_locator}    10s
    Input Text    ${search_channel_locator}    ${channel_name}
    Sleep    1s
    Press Keys    ${search_channel_locator}    ENTER

Check Element Visibility
    [Arguments]    ${locator}    ${should_be_visible}=True    ${timeout}=10    ${error_message}=${EMPTY}
    [Documentation]    Checks if an element appears or disappears
    ...    locator: Element locator to check
    ...    should_be_visible: True to check if element appears, False to check if it disappears
    ...    timeout: Maximum time to wait
    ...    error_message: Custom error message (optional)
    ${default_message}    Set Variable If    ${should_be_visible}    Element did not appear    Element did not disappear
    ${message}    Set Variable If    '${error_message}' == '${EMPTY}'    ${default_message}    ${error_message}
    Run Keyword If    ${should_be_visible}    
    ...    Wait Until Element Is Visible    ${locator}    ${timeout}    ${message}
    ...    ELSE    
    ...    Wait Until Element Is Not Visible    ${locator}    ${timeout}    ${message}

Check Channel Visibility
    [Arguments]    ${channel_name}    ${should_be_visible}=True    ${timeout}=10
    [Documentation]    Checks if channel appears or disappears in the list
    ...    channel_name: Name of the channel to check
    ...    should_be_visible: True to check if channel appears, False to check if it disappears
    ...    timeout: Maximum time to wait
    ${channel_title_locator}    Replace String    ${channel_title_locator}    {channel_name}    ${channel_name}
    ${message}    Set Variable If    ${should_be_visible}    
    ...    Channel "${channel_name}" did not appear in the list    
    ...    Channel "${channel_name}" did not disappear from the list
    Check Element Visibility    ${channel_title_locator}    ${should_be_visible}    ${timeout}    ${message}

Navigate To Channel Detail
    [Arguments]    ${channel_name}
    Navigate to list channel
    Wait Until Element Is Visible    ${create_channel_locator}    10s
    Click Element    ${create_channel_locator}
    Search Channel    ${channel_name}
    ${channel_title_locator}    Replace String    ${channel_title_locator}    {channel_name}    ${channel_name}
    Click Element    ${channel_title_locator}

Delete Channel
    Wait Until Element Is Visible    ${action_channel_detail_icon_locator}    10s
    Click Element    ${action_channel_detail_icon_locator}
    Wait Until Element Is Visible    ${action_channel_locator}    10s
    Click Element    ${action_channel_locator}
    Wait Until Element Is Visible    ${delete_locator}    10s
    Click Element    ${delete_locator}
    Wait Until Element Is Visible    ${confirm_delete_locator}    10s
    Click Element    ${confirm_delete_locator}

    
    
    