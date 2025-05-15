*** Settings ***
Library    SeleniumLibrary
Resource   ../../steps/Utility_Step.resource
Resource   ../../locators/Home_Page.resource
Resource   ../../steps/Home_Step.resource
Resource   ../../environment/Environment.resource
Suite Setup    Create announcement to all employees
# Test Setup    Create driver
# Test Teardown    Close Browser
Suite Teardown    Close Browser

*** Test Cases ***
TC05
    [Documentation]    Check that system sends notifications to all users when a 
    ...    new announcement is posted to all employees
    [Tags]    intranet_smoke_test
    Login to intranet with uid    uid_2
    Check Announcement Appear On Feed    ${message_on_feed}

TC07
    [Documentation]    Check that user can search posts in feed 
    ...    by inputting keyword to the Search bar
    [Tags]    intranet_smoke_test
    Search post by keyword    ${message_on_feed}

TC04
    [Documentation]    check user can create new feed
    [Tags]    intranet_smoke_test
    Navigate to create message page
    Send Message To User    tutna admin 1
    Check Message Appear On Feed    ${message_on_feed}


