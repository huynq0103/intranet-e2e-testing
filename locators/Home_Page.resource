*** Variables ***
${profile_locator}    //span[@id='user-name']
${logout_locator}    //a[@class='system-auth-form__item-link-all']
${calendar}    //span[contains(text(), 'Calendar')]
${create_event}    //button[contains(text(), 'Create')]
${sidebar_widget_birthdays}    //div[contains(@class, 'sidebar-widget-birthdays')]
${user_birth_name}    //span[contains(@class, 'user-birth-name')]
${user_birth_date}    //span[contains(@class, 'user-birth-date')]
${message_locator}    //div[@id='microoPostFormLHE_blogPostForm_inner']
${iframe_locator}    //iframe
${text_locator}    //body
${tag_user_locator}    //span[@class='ui-tag-selector-add-button-caption']
${send_button_locator}    //span[@id='blog-submit-button-save']
${feed_post_text_locator}    //div[@class='feed-post-text-block-inner-inner']//div[text()='{text}']
${more_post_locator}    //span[@id='feed-add-post-form-link-more']
${announcement_locator}    //span[text()='Announcement']
${announcement_text_locator}    //div[@id='blog-post-form-LHE_blogPostForm_inner']//div[@class='blog-post-form-text']
${announcement_receive_text_locator}    //div[@class='sidebar-widget sidebar-imp-messages']//a[text()='{text}']
${search_input_locator}    //input[@class='header-search-input']

    