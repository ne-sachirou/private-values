Feature: Set command
  Scenario: Set some types of values
    Given a project named "someProject"
    And run SET command with options "someProject.str1" and "value1"
    And run SET command with options "someProject.int1" and "42"
    And run SET command with options "someProject.float1" and "42.0"
    Then the file "~/.private-values/someProject/values.yml" should contain:
      """
      str1: value1
      int1: '42'
      float1: '42.0'
      """

  Scenario: Set with irnormal keys
    Given a project named "someProject"
    And run SET command with options "someProject.dot.dot" and "value"
    Then the file "~/.private-values/someProject/values.yml" should contain:
      """
      dot.dot: value
      """
    Given run SET command with options "'someProject.white space1'" and "value"
    Then the file "~/.private-values/someProject/values.yml" should contain:
      """
      white space1: value
      """
    Given run SET command with options "someProject.'white space2'" and "value"
    Then the file "~/.private-values/someProject/values.yml" should contain:
      """
      white space2: value
      """

  Scenario: Set a value, but the project isn't exist
    Given run SET command with options "someProject.key" and "value"
    Then it should fail with:
      """
      The project "someProject" isn't exist.
      Run `private-values new someProject`.
      """
