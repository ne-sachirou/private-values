Feature: Keys command
  Scenario: List keys of a project
    Given a project named "someProject"
    And run SET command with options "someProject.str1" and "value1"
    And run SET command with options "someProject.str2" and "value2"
    And run GET command with an option "someProject"
    Then it should pass with exactly:
      """
      str1
      str2
      """

