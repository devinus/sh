# Sh

[![Build Status](https://api.travis-ci.org/devinus/sh.svg?branch=master)](https://travis-ci.org/devinus/sh)

[![Support via Gratipay](https://raw.githubusercontent.com/twolfson/gittip-badge/0.2.1/dist/gittip.png)](https://gratipay.com/devinus/)

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


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/devinus/sh/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
