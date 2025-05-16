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
Create Channel With Type And User
    [Arguments]    ${channel_type}    ${user_name}
    Create driver
    Login to intranet with uid    uid_1
    Navigate to create channel page
    ${text_random}    Get Random String
    Set Suite Variable    ${channel_name}    ${text_random}
    Input Text    ${channel_name_locator}    ${channel_name}
    Sleep    1s
    Input Text    ${channel_description_locator}    ${text_random}
    Sleep    1s
    ${channel_type_locator}    Replace String    ${channel_type_locator}    {channel_type}    ${channel_type}
    Click Element    ${channel_type_locator}
    Sleep    1s
    Select User From Dropdown    ${tag_user_channel_locator}    ${user_name}
    Click Element    ${create_channel_button_locator}
    Sleep    2s
   #  Admin log out

 Check Channel Appear On List
    [Arguments]    ${channel_name}
    ${channel_title_locator}    Replace String    ${channel_title_locator}    {channel_name}    ${channel_name}
    Wait Until Element Is Visible    ${channel_title_locator}    10s


Add Member To Channel
    [Arguments]    ${user_name}
    Wait Until Element Is Visible    ${add_chat_member_locator}    10s
    Click Element    ${add_chat_member_locator}
    Sleep    1s
    Select User From Dropdown With Search    ${tag_add_member_channel_locator}    ${input_search_member_chat_locator}    ${user_name}
    Click Element    ${invite_locator}
    Sleep    2s
    Admin log out
    