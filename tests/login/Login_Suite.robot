*** Settings ***
Library    SeleniumLibrary
Resource   ../../steps/Utility_Step.resource
Resource   ../../environment/Environment.resource
Test Setup    Create driver
Test Teardown    Close Browser

*** Test Cases ***
TC01
    [Documentation]    check user can login to intranet
    [Tags]    intranet_smoke_test
    Login to intranet with uid    uid_1

TC02    
    [Documentation]    check user cann't login to intranet
    [Tags]    intranet_smoke_test
    Login to intranet with uid    uid_3
    Wait Until Page Contains    ${error_message}

    
    



