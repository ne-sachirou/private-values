Contributing
==
This software is licensed under [GPL-3](LICENSE).
- Submitting an Issue.
- Submitting a Pull Request.

Submitting a Pull Request
--
Pre Requirements:

- Haskell (GHC) & stack
- Ruby & Bundler

1. Fork.
2. Create a topic branch.
3. Fix a bug or add a new feature.
4. Add, commit, and push your changes.
5. Make a pull request.

To fix a bug or add a new feature:

1. Add a new Cucumber scenario.
2. `bundle exec rake test`. It must fail.
3. Fix a bug or add a new feature.
4. `bundle exec rake build`
5. `bundle exec rake test`. It must success.
