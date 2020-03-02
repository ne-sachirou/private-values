Feature: Rm command
  Scenario: Remove a project
    Given a project named "someProject"
    Then the following directories should exist:
      | ~/.private-values/someProject            |
    And run RM command with an option "someProject"
    Then the following directories should not exist:
      | ~/.private-values/someProject            |
