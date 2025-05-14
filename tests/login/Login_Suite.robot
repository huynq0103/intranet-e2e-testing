*** Settings ***
Library    SeleniumLibrary
Resource   ../../step/Utility_Step.resource
Resource   ../../environment/Environment.resource
Test Setup    Create driver
Test Teardown    Close Browser

*** Test Cases ***
Test login to intranet
    [Documentation]    login to intranet
    [Tags]    intranet
    Login to intranet with uid    uid_2


    
    



