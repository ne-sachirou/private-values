private-values
==
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

