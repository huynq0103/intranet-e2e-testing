*** Settings ***
Library    SeleniumLibrary
Resource   ../../steps/Utility_Step.resource
Test Setup    Create driver
Test Teardown    Close Browser

*** Test Cases ***
Get upcoming birthday
   [Documentation]    get birthday
   [Tags]    intranet
   Login to intranet with uid    uid_1
   Get birthday







    
    



