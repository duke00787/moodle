@mod @mod_quiz
Feature: Add random questions to quiz
  In order to quickly create quiz
  As a teacher
  I need to add random questions to quiz

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Terry1    | Teacher1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    And the following "question categories" exist:
      | contextlevel | reference | name            | questioncategory |
      | Course       | C1        | Default for C1  | Top              |
      | Course       | C1        | Category1       | Default for C1   |
      | Course       | C1        | SubCategory1    | Category1        |
      | Course       | C1        | SubSubCategory1 | SubCategory1     |
      | Course       | C1        | SubCategory2    | Category1        |
      | Course       | C1        | Category2       | Default for C1   |
    And the following "activities" exist:
      | activity   | name           | course | idnumber |
      | quiz       | Test quiz name | C1     | quiz1    |
    When I log in as "teacher1"
    And I follow "Course 1"
    And I follow "Test quiz name"
    And I press "Edit quiz"
    And I open the "last" add to quiz menu
    And I follow "a random question"

  @javascript
  Scenario: Add random question from each subcategory of a category
    When I set the field "id_category" to "Category1"
    Then I should see "Random (SubCategory1)"
    And I should see "Random (SubCategory2)"

  @javascript
  Scenario: Add random question from each subcategory of a category including questions from subcategories
    When I set the field "includesubcategories" to "1"
    And I set the field "id_category" to "Category1"
    Then I should see "Random (SubCategory1 and subcategories)"
    And I should see "Random (SubCategory2 and subcategories)"

  @javascript
  Scenario: Add several random questions from each subcategory of a category
    And I set the field "numbertoadd" to "2"
    Then "Random (Category1)" should have number "1" on the edit quiz page
    And "Random (Category1)" should have number "2" on the edit quiz page
    And "Random (Category2)" should have number "3" on the edit quiz page
    And "Random (Category2)" should have number "4" on the edit quiz page

  @javascript
  Scenario: Button "Add random question from each subcategory of this category" should be disabled
    if category has no subcategories and enabled otherwise
    When I set the field "id_category" to "SubCategory2"
    Then the "Add random question from each subcategory of this category" "button" should be disabled
    When I set the field "id_category" to "SubCategory1"
    Then the "Add random question from each subcategory of this category" "button" should be enabled
