# bats-file

`bats-file` is a helper library providing common filesystem related
assertions for [Bats][bats].

Assertions are functions that perform a test and output relevant
information on failure to help debugging. They return 1 on failure and 0
otherwise. Output, [formatted][bats-support-output] for readability, is
sent to the standard error to make assertions usable outside of `@test`
blocks too.

Dependencies:
- [`bats-support`][bats-support] - output formatting

See the [shared documentation][bats-docs] to learn how to install and
load this library.


## Usage

### `assert_file_exist`

Fail if the given file or directory does not exist.

```bash
@test 'assert_file_exist()' {
  assert_file_exist /path/to/non-existent-file
}
```

On failure, the path is displayed.

```
-- file does not exist --
path : /path/to/non-existent-file
--
```


### `assert_file_not_exist`

Fail if the given file or directory exists.

```bash
@test 'assert_file_not_exist() {
  assert_file_not_exist /path/to/existing-file
}
```

On failure, the path is displayed.

```
-- file exists, but it was expected to be absent --
path : /path/to/existing-file
--
```


## Transforming displayed paths

Sometimes paths can be long and tiresome to parse to the human eye. To
help focus on the interesting bits, all functions support hiding part of
the displayed paths by replacing it with an arbitrary string.

A single [pattern substitution][bash-pe] is performed on the path before
displaying it.

```
${path/$BATSLIB_FILE_PATH_REM/$BATSLIB_FILE_PATH_ADD}
```

The longest match of the pattern `BATSLIB_FILE_PATH_REM` is replaced
with `BATSLIB_FILE_PATH_ADD`. To anchor the pattern to the beginning or
the end, prepend a `#` or `%`, respectively.

For example, the following example hides the path of the temporary
directory where the test takes place.

```bash
setup {
  TEST_TEMP_DIR='/tmp/bats-app-temp-dir'
  BATSLIB_FILE_PATH_REM="#${TEST_TEMP_DIR}"
  BATSLIB_FILE_PATH_ADD='<temp>'
}

@test 'assert_file_exist()' {
  assert_file_exist "${TEST_TEMP_DIR}/path/to/non-existent-file"
}
```

On failure, only the relevant part of the path is shown.

```
-- file does not exist --
path : <temp>/path/to/non-existent-file
--
```


<!-- REFERENCES -->

[bats]: https://github.com/sstephenson/bats
[bats-support-output]: https://github.com/ztombol/bats-support#output-formatting
[bats-support]: https://github.com/ztombol/bats-support
[bats-docs]: https://github.com/ztombol/bats-docs
[bash-pe]: https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
