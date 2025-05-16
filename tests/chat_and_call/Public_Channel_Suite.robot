*** Settings ***
Library    SeleniumLibrary
Resource   ../../steps/Utility_Step.resource
Resource   ../../environment/Environment.resource
Resource   ../../steps/Chat_And_Call_Step.resource
Suite Setup    Create Channel With Type And User    Public    tutna HR
# Test Setup    Create driver
# Test Teardown    Close Browser
Suite Teardown    Close Browser

*** Test Cases ***
TC23
    [Documentation]    Check that user who have permission can edit the channel by clicking on the "Edit" option
    [Tags]    intranet_smoke_test
    Add member to channel    Tutna 5
TC22
    [Documentation]    Check that all stakeholders is added to the channel after creating
    [Tags]    intranet_smoke_test
    Login to intranet with uid    uid_2
    Navigate to list channel
    Check Channel Appear On List    ${channel_name}



