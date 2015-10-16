Feature: Projects command
  Scenario: List projects
    Given a project named "someProject"
    And a project named "otherProject"
    And run PROJECTS command
    Then it should pass with exactly:
      """
      otherProject
      someProject
      """
