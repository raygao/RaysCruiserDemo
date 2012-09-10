Feature: Order Management
	To have media playing when and how it is desired to, a user will need to be able to configure the order

	Scenario: Changing the duration a content item plays
		Given that there exists a content item in the order with an incorrect duration
		When I open the corresponding “Duration” drop-down menu
		Then I am presented with a selection of four different durations, .15, .30, and .45 seconds

	Scenario: Changing the order order
		Given that I identified a content item that needs to play elsewhere in the order
		When I select and drag the content item anywhere in the order
		Then the order order has been changed appropriately

	Scenario: Removing content from the order
		Given that there is content that needs to be removed from the order
		When I select the corresponding “Remove” link in the “Actions” column of the order
		Then the content item disappears from the order

	Scenario: Previewing the order
		Given that it is necessary to view the effect of changes before publishing them
		When I select the “Preview” button
		Then the entire playback is opened in a new window for viewing

	Scenario: Publishing the order
		Given that once everything is approved to play
		When I select the “Publish” button
		Then the changes are live and I am provided a link of where the playback is located
