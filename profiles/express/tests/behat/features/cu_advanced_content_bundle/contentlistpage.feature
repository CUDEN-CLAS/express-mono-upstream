@AdvContentBundle
Feature: the Content List page
In order to create a node with a list of other nodes
As user with the proper role
I should be able to access and use the Content List page


Scenario Outline: A user with the proper role should be able to access the content list page
  Given I am logged in as a user with the <role> role
  When I go to "node/add/content-list-page"
  Then I should see <message>

  Examples:
  | role            | message         |
  | edit_my_content | "Access denied" |
  | edit_only       | "Access denied" |
  | content_editor  | "Create Content List Page" |
  | site_owner      | "Create Content List Page" |
  | administrator   | "Create Content List Page" |
  | developer       | "Create Content List Page" |


Scenario: An anonymous user should not be able to access the form
  Given I go to "node/add/content-list-page"
  Then I should see "Access denied"

#CREATING A CONTENT LIST PAGE
# @javascript
Scenario: A content list page can pull in articles, pages and persons
Given I am logged in as a user with the "site_owner" role
# CREATE BASIC PAGE
And I am on "node/add/page"
And fill in "edit-title" with "List Test Page"
# And I follow "Disable rich-text"
And fill in "Body" with "Demo body content"
When I uncheck "edit-menu-enabled"
And I press "Save"
# CREATE ARTICLE
And I go to "node/add/article"
And fill in "edit-title" with "List Test Article"
# And I follow "Disable rich-text"
And fill in "Body" with "Demo article content"
And I press "Save"
# CREATE PERSON
And I go to "node/add/person"
And fill in "First Name" with "MyFirst"
And fill in "Last Name" with "MyLast"
And I press "Save"
# CREATE CONTENT LIST PAGE
And I go to "node/add/content-list-page"
And I should see an "#edit-addanother" element
And fill in "edit-title" with "Test Content List Page"
And fill in "edit-field-content-list-reference-und-0-target-id" with "List Test Page"
And I press "field_content_list_reference_add_more"
# And I wait for the ".ajax-new-content" element to appear
And fill in "edit-field-content-list-reference-und-1-target-id" with "List Test Article"
And I press "field_content_list_reference_add_more"
# And I wait for the ".ajax-new-content" element to appear
And fill in "edit-field-content-list-reference-und-2-target-id" with "MyFirst MyLast"
And I press "field_content_list_reference_add_more"
# And I wait for the ".ajax-new-content" element to appear
And I press "Save"
Then I should see "Content List Page Test Content List Page has been created."
And I should see the link "List Test Page"
And I should see the link "List Test Article"
And I should see the link "MyFirst MyLast"

Scenario: An EditOnly can edit a Content Grid
Given I am logged in as a user with the "edit_only" role
And am on "admin/content"
And I follow "Test Content List Page"
Then I should see the link "Edit"
And I follow "Edit"
Then I should see "This document is now locked against simultaneous editing."
And I should not see "Delete"
