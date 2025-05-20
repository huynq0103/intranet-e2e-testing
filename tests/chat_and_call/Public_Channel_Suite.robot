*** Settings ***
Library    SeleniumLibrary
Resource   ../../steps/Utility_Step.resource
Resource   ../../environment/Environment.resource
Resource   ../../steps/Chat_And_Call_Step.resource
Suite Setup    Create Channel With Type And Member   uid_1    Public    ${user_02}
# Test Setup    Create driver
# Test Teardown    Close Browser
Suite Teardown    Close Browser And Clean Session

*** Test Cases ***
TC27
    [Documentation]    Check that user who have permission can edit the channel by add new member
    [Tags]    intranet_smoke_test
    Add member to channel    ${user_04}
TC21
    [Documentation]    Check that all stakeholders is added to the channel after creating
    [Tags]    intranet_smoke_test
    Login to intranet with uid    uid_2
    Navigate to list channel
    Check Member Was Added To Channel    ${channel_name}    ${user_02}

TC22
    [Documentation]    Check that the Public channel shows up in the channel list so that anyone can subscribe/ view channel post
    [Tags]    intranet_smoke_test
    Wait Until Element Is Visible    ${create_channel_locator}    10s
    Click Element    ${create_channel_locator}
    Create Channel With Type And Member   uid_2    Public    None
    Close Browser And Clean Session
    Login to intranet with uid    uid_3
    Navigate to list channel
    Check Channel Appear On List    ${channel_name}

TC24
    [Documentation]    Check that everyone can search for Public channels in the Channels tab
    [Tags]    intranet_smoke_test
    Wait Until Element Is Visible    ${create_channel_locator}    10s
    Click Element    ${create_channel_locator}
    Search Channel    ${channel_name}
    Check Channel Visibility    ${channel_name}



