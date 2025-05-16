*** Variables ***
${channel_menu_locator}    //div[@title='View Open Channel chat']
${channel_locator}    //div[@title='Channels']
${create_channel_locator}    //div[@class='bx-im-list-container-channel__header_create-channel']
${channel_name_locator}    //input[@placeholder='Channel name']
${channel_description_locator}    //textarea[@placeholder='Enter channel description']
${channel_type_locator}    //div[text()='{channel_type}']
${tag_user_channel_locator}    (//span[@class='ui-tag-selector-add-button-caption'])[3]
${create_channel_button_locator}   //button/span[text()='Create channel']
${channel_title_locator}    //span[text()='{channel_name}']
${add_chat_member_locator}    //div[@title='Add chat members']
${tag_add_member_channel_locator}    (//div[@class='ui-tag-selector-container'])[3]
${input_search_member_chat_locator}    (//div[@class='ui-tag-selector-container'])[3]//input
${invite_locator}    //span[text()='Invite']    