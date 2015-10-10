Feature: Path command
  Scenario: Get the project path
    Given a project named "someProject"
    And run PATH command with an option "someProject"
    Then the output should match %r<^/.+/\.private-values/someProject$>

  Scenario: Get a project path, but the project isn't exist
    Given run PATH command with an option "someProject"
    Then it should fail with:
      """
      The project "someProject" isn't exist.
      Run `private-values new someProject`.
      """
