private-values
==
```
private-values [COMMAND]

COMMAND
--
new PROJECT          \tCreate new private values.
rm PROJECT           \tRemove private values.
set PROJECT.KEY VALUE\tSet a private value.
get PROJECT.KEY      \tGet the private value.
path PROJECT         \tPath to the private files.

~/private-values.rc
--
values-dir: ~/.private-values
password: PASSWORD
```

Usage
--
```yaml
# private-values.rc
values-dir: ~/.dotfiles/private-values
password: PASSWORD
```

```sh
private-values new someProject
private-values set someProject.someValue value
```

```sh
# someProject/.envrc
export SOME_VALUE=private-values get someProject.someValue
export PATH=$PATH:$(private-values path someProject)
```

CONTRIBUTE
--

