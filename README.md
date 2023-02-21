<div align="center">

# asdf-shell2http [![Build](https://github.com/ORCID/asdf-shell2http/actions/workflows/build.yml/badge.svg)](https://github.com/ORCID/asdf-shell2http/actions/workflows/build.yml) [![Lint](https://github.com/ORCID/asdf-shell2http/actions/workflows/lint.yml/badge.svg)](https://github.com/ORCID/asdf-shell2http/actions/workflows/lint.yml)


[shell2http](https://github.com/msoap/shell2http) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add shell2http https://github.com/ORCID/asdf-shell2http.git
```

shell2http:

```shell
# Show all installable versions
asdf list-all shell2http

# Install specific version
asdf install shell2http latest

# Set a version globally (on your ~/.tool-versions file)
asdf global shell2http latest

# Now shell2http commands are available
shell2http --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

