# Sh

An Elixir module inspired by Python's [sh](http://amoffat.github.io/sh/)
package. `Sh` allows you to call any program as if it were a function.

## Example

```iex
iex> Sh.echo "Hello World!"
"Hello World!\n"
iex> Sh.curl("http://example.com/", o: "page.html", silent: true)
```
