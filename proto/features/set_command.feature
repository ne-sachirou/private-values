Feature: Set command
  Scenario: Set some types of values
    Given a project named "someProject"
    And run SET command with options "someProject.str1" and "value1"
    And run SET command with options "someProject.int1" and "42"
    And run SET command with options "someProject.float1" and "42.0"
    Then the file "~/.private-values/someProject/values.yml" should contain:
      """
      str1: value1
      int1: 42
      float1: 42.0
      """
