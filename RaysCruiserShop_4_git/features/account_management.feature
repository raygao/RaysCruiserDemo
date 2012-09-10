Feature: Account management
	In order to update account information a user should be able to manage an account.

	Scenario: Update existing information
		Given I am on the settings page
		When I change any of the text in the text boxes and select the “Save” button
		Then the information should be updated

	Scenario: Cancel update
		Given I have changed the text in some/all of the text boxes but have not yet selected the “Save” button.
		When I select the “Cancel” button
		Then the changes are removed and the settings page should be back to its original state
