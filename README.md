linter-pep257
=============

A [Linter][] plugin to lint Python docstrings according to the semantics and conventions spec'd in [pep257][spec].

In use side-by-side with the flake8 linter:

![Screenshot of pep257 feedback](https://cloud.githubusercontent.com/assets/154988/9623112/5ee0bf1e-510a-11e5-815b-a339fa85ebac.png)

## Installation

1. [Install Linter][].

1. Install python package [pep257][], run:
  ```
  pip install pep257
  ```

1. Install package, run:
  ```
  apm install linter-pep257
  ```

## Configuration

setting | values
--- | ---
Error codes to ignore (comma separated) | Example: `D100,D101` - [all available error codes][pep257 codes]
Path to executable pep257 cmd | Default: pep257

If using python version management, like [pyenv][], the path configuration will need to be set.  For pyenv, the path for pep257 is discoverable by executing:
```
pyenv which pep257
```

[Linter]: https://github.com/atom-community/linter
[Install Linter]: https://github.com/atom-community/linter#installation
[pep257]: https://pypi.python.org/pypi/pep257
[pep257 codes]: http://pep257.readthedocs.org/en/latest/error_codes.html
[pyenv]: https://github.com/yyuu/pyenv
[spec]: https://www.python.org/dev/peps/pep-0257/
