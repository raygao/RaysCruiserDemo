Feature: Account creation and access
	In order to use Modal a user should be able to create an account and then access it.

	Scenario: Create a new user login
		Given I am connected to the Internet and browsed to the home page
		When I create a new user named ModalUser
		Then I should have access to the ModalUser account and I’m sent to the Content Page

	Scenario: Logging in to my account
		Given I am at the “sign in” page and logged out
		When I sign in to the ModalUser account using proper credentials
		Then I should have access to the ModalUser account and I’m sent to the Content page

	Scenario: Logging in to my account
		Given I am signed in to the ModalUser account
		When I select the “Log out” link
		Then I should be logged out and directed to the Sign In page
