Feature: Content creation and management
	In order to have content to manage the user must be able to add/create/remove it.

	Scenario: Add branded logo and header text
		Given I am on the Content page
		When I select the “Browse” button in the “Branding” section, it opens a window where I choose the desired image, enter the header text and select the “Save” button
		Then the logo and header text are reflected as being updated

	Scenario: Open the Content Creation Window
		Given I am on the content page
		When I select the “Add New” button under the Content Library
		Then a new window opens with a text box for “Header” and radio buttons for “Image”, “Text”, and “Text and Image”

	Scenario: Access to creating an Image item in Content Creation Window
		Given I have the Content Creation Window Open
		When I select the “Image” radio button
		Then the “Upload” button with path box appears

	Scenario: Access to creating a Text item in Content Creation Window
		Given I have the Content Creation Window Open
		When I select the “Text” radio button
		Then the “Description” text box appears

	Scenario: Access to creating a Text and Image item in Content Creation Window
		Given I have the Content Creation Window Open
		When I select the “Text and Image” radio button
		Then the “Description” text box, “Align Image” radio buttons and the “Upload” button with path box appears

	Scenario: Adding content to the Content Library
		Given I entered valid information in Content Creation Window
		When I select the “Save” button
		Then the window closes and the new item appears in the Content Library

	Scenario: Starting over in the Content Creation Window
		Given that there is invalid information in Content Creation Window
		When I select the “Reset” button
		Then all information entered is removed

	Scenario: Alerting that invalid information has been entered
		Given that there is invalid information in Content Creation Window
		When I select the “Save” button
		Then the window remains open and alerts me to what is incorrect

	Scenario: Editing content in the Content Library
		Given that there is content that needs to be edited in the Content Library
		When I select the corresponding “Edit” link in the “Action” column of the Content Library
		Then the Content Creation Window opens with all of the content item’s information available to edit

	Scenario: Duplicating content in the Content Library
		Given that there is content that needs to be duplicated in the Content Library
		When I select the corresponding “Copy” link in the “Action” column of the Content Library
		Then the Content Creation Window opens with the new content item available to edit, if necessary, and save

	Scenario: Removing content from the Content Library
		Given that there is content that needs to be removed from the Content Library
		When I select the corresponding “Delete” link in the “Action” column of the Content Library
		Then the content item disappears from the Content Library

	Scenario: Sending content items to order
		Given I have selected the corresponding checkboxes for content
		When I select the “Save Selected to order” link
		Then I am directed to the order page and all selected content items are added to the order with their duration defaulted to 15 seconds
