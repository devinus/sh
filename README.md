# Sh

[![Build Status](https://secure.travis-ci.org/devinus/sh.png?branch=master)](http://travis-ci.org/devinus/sh)

[![Support via Gittip](https://rawgithub.com/twolfson/gittip-badge/0.2.1/dist/gittip.png)](https://www.gittip.com/devinus/)

An Elixir module inspired by Python's [sh](http://amoffat.github.io/sh/)
package. `Sh` allows you to call any program as if it were a function.

## Example

```iex
iex> Sh.echo "Hello World!"
"Hello World!\n"
```

## Options

`Sh` commands accept as the last argument a list of options.

```elixir
Sh.curl "http://example.com/", o: "page.html", silent: true
""
```

The equivalent call without using this feature would be:

```elixir
Sh.curl "-o", "page.html", "--silent", "http://example.com/"
```

## Underscores

Underscores in a program name or keyword options are converted to dashes.
