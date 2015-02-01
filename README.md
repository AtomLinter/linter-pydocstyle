linter-pep257
=============

A [Linter][] plugin to lint Python docstrings according to the semantics and conventions spec'd in [pep257][spec].

In use side-by-side with the flake8 linter:

![Screenshot of pep257 feedback](https://raw.githubusercontent.com/AtomLinter/linter-pep257/master/screenshot.png)

## Installation

1. If Linter is not already installed, follow the [linter installation instructions][linter-install].

1. Configure linter to show "info" messages:

  * Open the config for Linter.
  * Check option "Show Info Messages".

1. Install python package [pep257][].

  Execute in a terminal:
  ```
  pip install pep257
  ```

1. Install plugin.

  Execute:
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


[Linter]: https://github.com/AtomLinter/Linter
[linter-install]: https://github.com/AtomLinter/Linter#installation
[pep257]: https://pypi.python.org/pypi/pep257
[pep257 codes]:https://github.com/GreenSteam/pep257/#error-codes
[pyenv]: https://github.com/yyuu/pyenv
[spec]: http://legacy.python.org/dev/peps/pep-0257/

## Donation
[![Share the love!](https://chewbacco-stuff.s3.amazonaws.com/donate.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KXUYS4ARNHCN8)

[![donate-paypal](https://s3-eu-west-1.amazonaws.com/chewbacco-stuff/donate-paypal.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KXUYS4ARNHCN8)

<a class="coinbase-button" data-code="2945dab392cb1cefbb7097e4cd17a603" data-button-style="custom_small" href="https://www.coinbase.com/checkouts/2945dab392cb1cefbb7097e4cd17a603">Donate Bitcoins</a><script src="https://www.coinbase.com/assets/button.js" type="text/javascript"></script>
