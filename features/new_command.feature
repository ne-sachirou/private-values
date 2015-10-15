Feature: New command
  Scenario: Create a new project
    Given using "private-values.default.rc" for a rc file
    And run NEW command with an option "someProject"
    Then the following directories should exist:
      |                                          |
      | ~/.private-values/someProject            |
    And the following files should exist:
      |                                          |
      | ~/.private-values/someProject/values.yml |

  Scenario: Create a new project in other place
    Given using "private-values.otherdir.rc" for a rc file
    And run NEW command with an option "some-project"
    Then the following directories should exist:
      |                                     |
      | ~/other/dir/some-project            |
    And the following files should exist:
      |                                     |
      | ~/other/dir/some-project/values.yml |

  Scenario: Create an irregular name project
    Given using "private-values.default.rc" for a rc file
    And run NEW command with an option "some.project"
    Then it should fail with "The project name shold only contain [-A-Za-z0-9_]"
