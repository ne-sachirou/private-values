private-values
==
Delete private values and private files from youre git repos.

```
private-values [COMMAND]

COMMAND
--
new PROJECT            Create new private values.
rm PROJECT             Remove private values.
set PROJECT.KEY VALUE  Set a private value.
get PROJECT.KEY        Get the private value.
path PROJECT           Path to the private files.

~/private-values.rc
--
values-dir: ~/.private-values
```

Usage
--
```yaml
# ~/private-values.rc
values-dir: ~/.dotfiles/private-values
```

```sh
mkdir someProject && cd someProject
git init

private-values new someProject
private-values set someProject.someValue value
echo ".envrc" > .gitignore

echo "," > .gitignore
ln -s $(private-values path someProject) ,
echo "#!/bin/bash\necho HELLO" > ,/hello.sh
chmod +x ,/hello.sh
```

```sh
# someProject/.envrc
export SOME_VALUE=$(private-values get someProject.someValue)
export PATH=$PATH:$(private-values path someProject)
```

CONTRIBUTEING
--
### Pre Requirements
- Haskell (GHC) & stack
- Ruby & Bundler

We develop 2 same softwares: Main and Proto.<br/>
Main is here. This's written in Haskell.<br/>
Proto is placed at proto/. It's written in Ruby.

1. Fix a bug or add a new feature in Proto.
  1. Add a new Cucumber scenario.
  2. `bundle exec rake test`. It must fail.
  3. Fix a bug or add a new feature.
  4. `bundle exec rake test`. It must success.
2. Fix a bug or add a new feature in Main.
  1. Fix a bug or add a new feature.
  2. `bundle exec rake build test`. It must success.

TODO
--
- Remove proto/.
