Feature: Get command
  Scenario: Get some type of values
    Given a project named "someProject"
    And run SET command with options "someProject.str1" and "value1"
    And run GET command with an option "someProject.str1"
    Then the output should contain exactly "value1"
    Given run SET command with options "someProject.int1" and "42"
    And run GET command with an option "someProject.int1"
    Then the output should contain exactly "42"
    Given run SET command with options "someProject.float1" and "42.0"
    And run GET command with an option "someProject.float1"
    Then the output should contain exactly "42.0"

  Scenario: Get Unicode keys and values
    Given a project named "someProject"
    And run SET command with options "someProject.this-value" and "この値"
    And run GET command with an option "someProject.this-value"
    Then the output should contain exactly "この値"
    Given run SET command with options "someProject.その値" and "'That value'"
    And run GET command with an option "someProject.その値"
    Then the output should contain exactly "That value"

  Scenario: Get a value, but the project isn't exist
    Given run GET command with an option "someProject.key"
    Then it should fail with:
      """
      The project "someProject" isn't exist.
      Run `private-values new someProject`.
      """
