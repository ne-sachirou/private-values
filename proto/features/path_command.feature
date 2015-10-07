Feature: Path command
  Scenario: Get the project path
    Given a project named "someProject"
    And run PATH command with an option "someProject"
    Then the output should match %r<^/.+/\.private-values/someProject$>
