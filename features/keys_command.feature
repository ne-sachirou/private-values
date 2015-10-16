Feature: Keys command
  Scenario: List keys of a project
    Given a project named "someProject"
    And run SET command with options "someProject.str1" and "value1"
    And run SET command with options "someProject.str2" and "value2"
    And run KEYS command with an option "someProject"
    Then it should pass with exactly:
      """
      str1
      str2
      """

  Scenario: List keys of a project, but the project isn't exist
    Given run KEYS command with an option "someProject"
    Then it should fail with:
      """
      The project "someProject" isn't exist.
      Run `private-values new someProject`.
      """
