Feature: Get command
  Scenario: Get a list of projects
    Given a project named "someProject"
    And a project named "otherProject"
    And run GET command with no options
    Then it should pass with exactly:
      """
      otherProject
      someProject
      """

  Scenario: Get a list of keys and values
    Given a project named "someProject"
    And run SET command with options "someProject.str1" and "value1"
    And run SET command with options "someProject.str2" and "value2"
    And run GET command with an option "someProject"
    Then it should pass with exactly:
      """
      str1: values1
      str2: values2
      """

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

  Scenario: Get a value, but the project isn't exist
    Given run GET command with an option "someProject.key"
    Then it should fail with:
      """
      The project "someProject" isn't exist.
      Run `private-values new someProject`.
      """
