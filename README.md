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
# private-values.rc
values-dir: ~/.dotfiles/private-values
```

```sh
private-values new someProject
private-values set someProject.someValue value

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

CONTRIBUTE
--

