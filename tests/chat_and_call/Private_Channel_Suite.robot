*** Settings ***
Library    SeleniumLibrary
Resource   ../../steps/Utility_Step.resource
Resource   ../../environment/Environment.resource
Resource   ../../steps/Chat_And_Call_Step.resource
Suite Setup    Create Channel With Type And Member    uid_1    Private    ${user_03}
Suite Teardown    Close Browser

*** Test Cases ***
TC23
    [Documentation]    Check that non-member cannot search for Private channels in the Channels tab 
    [Tags]    intranet_smoke_test
    Close Browser And Clean Session
    Login to intranet with uid    uid_2
    Navigate to list channel
    Check Channel Visibility    ${channel_name}    False

TC25
    [Documentation]    Check that the Private channel is visible only to subscribers  
    [Tags]    intranet_smoke_test
    Close Browser And Clean Session
    Login to intranet with uid    uid_3
    Navigate to list channel
    Wait Until Element Is Visible    ${create_channel_locator}    10s
    Click Element    ${create_channel_locator}
    Search Channel    ${channel_name}
    Check Channel Visibility    ${channel_name}

TC26
    [Documentation]    Check that owner can delete the channel by clicking on the Delete option  
    [Tags]    intranet_smoke_test
    Close Browser And Clean Session
    Login to intranet with uid    uid_1
    Navigate To Channel Detail    ${channel_name}
    Delete Channel    
    # Check Channel Not Appear On List    ${channel_name}


