private-values
==
Delete private values and private files from youre git repos.

```
private-values [COMMAND]

COMMAND
--
new PROJECT            Create new private values.
rm PROJECT             Remove private values.
projects               List projects.
keys PROJECT           List keys in the project.
set PROJECT.KEY VALUE  Set a private value.
get PROJECT.KEY        Get the private value.
path PROJECT           Path to the private files.

~/private-values.rc
--
values-dir: ~/.private-values
```

Usage
--
### Global Setting
Put the config file at `~/private-values.rc`:

```yaml
# ~/private-values.rc
values-dir: ~/.private-values
```

Make `~/.private-values` as your private Git repo.

### Store Private Values of Your Project
Let `some-project` is your Git project.

Create a new private-values project and then set private values.

```sh
private-values new someProject
private-values set someProject.someValue1 value1
private-values set someProject.someValue2 value2
```

Set the values to local environment variables using [direnv][1].
Write `some-project/.envrc`:

```sh
# some-project/.envrc
export SOME_VALUE1=$(private-values get someProject.someValue1)
export SOME_VALUE2=$(private-values get someProject.someValue2)
```

```sh
direnv allow
```

And ignore the envrc.

```
# some-project/.gitignore or ~/.gitignore
.envrc
```

Your private values are stored at `~/.private-values/someProject/values.yml`.

### Store Private Files of Your Project
For example I make `hello.sh`.

```sh
echo "," > .gitignore
ln -s $(private-values path someProject) ,
echo "#!/bin/bash\necho HELLO" > ,/hello.sh
chmod +x ,/hello.sh
,/hello.sh
```

[direnv][1] helps us.

```sh
# some-project/.envrc
export PATH=$PATH:$(private-values path someProject)
```

```sh
direnv allow
hello.sh
```

What is NOT private-values?
--
- private-values dose NOT manage secrets in your organization. [valut](https://vaultproject.io) may help you.
- private-values dose NOT encrypt your secrets. Use Bcrypt or other crypt methods.
- private-values dose NOT store your secrets on a safe cloud server. I use private Git repo, or encrypted 7zip archive in a cloud storage for this purpose.
- private-values is NOT a fast database backend.

What IS private-values?
--
- private-values aggregate your private values and files under 1 directory.
- The values file `values.yml` is editable for human. It's just YAML format which maps a text key to a text value.

CONTRIBUTING
--
### Pre Requirements
- Haskell (GHC) & stack
- Ruby & Bundler

To fix a bug or add a new feature:

1. Add a new Cucumber scenario.
2. `bundle exec rake test`. It must fail.
3. Fix a bug or add a new feature.
4. `bundle exec rake build`
5. `bundle exec rake test`. It must success.

TODO
--
- [ ] Remove proto/.
- [ ] Short command name.
- [ ] CI
- [ ] Release 0.1.0

[1]: http://direnv.net/
<!-- vim:set ft=markdown: -->
