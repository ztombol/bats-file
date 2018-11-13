# bats-file

[![GitHub license](https://img.shields.io/badge/license-CC0-blue.svg)](https://raw.githubusercontent.com/peshay/bats-file/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/peshay/bats-file.svg)](https://github.com/peshay/bats-file/releases/latest)
[![Build Status](https://travis-ci.org/peshay/bats-file.svg?branch=master)](https://travis-ci.org/peshay/bats-file)

`bats-file` is a helper library providing common filesystem related
assertions and helpers for [Bats][bats].

Assertions are functions that perform a test and output relevant
information on failure to help debugging. They return 1 on failure and 0
otherwise. Output, [formatted][bats-support-output] for readability, is
sent to the standard error to make assertions usable outside of `@test`
blocks too.

Features:
- [assertions](#usage)
- [temporary directory handling](#working-with-temporary-directories)

Dependencies:
- [`bats-support`][bats-support] - output formatting, function call
  restriction

See the [shared documentation][bats-docs] to learn how to install and
load this library.


## Usage

### `assert_exist`

Fail if the given file or directory does not exist.

```bash
@test 'assert_exist()' {
  assert_exist /path/to/non-existent-file-or-dir
}
```

On failure, the path is displayed.

```
-- file or directory does not exist --
path : /path/to/non-existent-file-or-dir
--
```

### `assert_file_exist`

Fail if the given file does not exist.

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

### `assert_dir_exist`

Fail if the given directory does not exist.

```bash
@test 'assert_dir_exist()' {
  assert_file_exist /path/to/non-existent-directory
}
```

On failure, the path is displayed.

```
-- directory does not exist --
path : /path/to/non-existent-directory
--
```

### `assert_link_exist`

Fail if the given symbolic link does not exist.

```bash
@test 'assert_link_exist()' {
  assert_file_exist /path/to/non-existent-link-file
}
```

On failure, the path is displayed.

```
-- symbolic link does not exist --
path : /path/to/non-existent-link-file
--
```

### `assert_block_exist`

Fail if the given block special file does not exist.

```bash
@test 'assert_block_exist()' {
  assert_file_exist /path/to/non-existent-block-file
}
```

On failure, the path is displayed.

```
-- block special file does not exist --
path : /path/to/non-existent-block-file
--
```

### `assert_character_exist`

Fail if the given character special file does not exist.

```bash
@test 'assert_character_exist()' {
  assert_file_exist /path/to/non-existent-character-file
}
```

On failure, the path is displayed.

```
-- character special file does not exist --
path : /path/to/non-existent-character-file
--
```

### `assert_socket_exist`

Fail if the given socket does not exist.

```bash
@test 'assert_socket_exist()' {
  assert_file_exist /path/to/non-existent-socket
}
```

On failure, the path is displayed.

```
-- socket does not exist --
path : /path/to/non-existent-socket
--
```

### `assert_fifo_exist`

Fail if the given named pipe does not exist.

```bash
@test 'assert_fifo_exist()' {
  assert_file_exist /path/to/non-existent-fifo-file
}
```

On failure, the path is displayed.

```
-- fifo does not exist --
path : /path/to/non-existent-fifo-file
--
```


### `assert_file_executable`

Fail if the given file is not executable.

```bash
@test 'assert_file_executable()' {
  assert_file_executable /path/to/executable-file
}
```

On failure, the path is displayed.

```
-- file is not executable --
path : /path/to/executable-file
--
```

### `assert_files_equal`

Fail if the given files are not the same.

```bash
@test 'assert_files_equal()' {
  assert_files_equal /path/to/file1 /path/to/file2
}
```

On failure, the path is displayed.

```
-- files are not the same --
path1 : /path/to/file
path2 : /path/to/same_file
--
```
### `assert_symlink_to`
Fail if the given file is not a symbolic to a defined target.
```bash
@test 'assert_symlink_to() {
  assert_symlink_to /path/to/source-file /path/to/symlink
}
```
On failure, the path is displayed.
```
-- symbolic link does not have the correct target --
path : /path/to/symlink
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
-- file or directory exists, but it was expected to be absent --
path : /path/to/existing-file
--
```

### `assert_dir_not_exist`

Fail if the given directory exists.

```bash
@test 'assert_dir_not_exist() {
  assert_dir_not_exist /path/to/existing-directory
}
```

On failure, the path is displayed.

```
-- directory exists, but it was expected to be absent --
path : /path/to/existing-directory
--
```

### `assert_link_not_exist`

Fail if the given symbolic link exists.

```bash
@test 'assert_link_not_exist() {
  assert_file_not_exist /path/to/existing-link-file
}
```

On failure, the path is displayed.

```
-- symbolic link exists, but it was expected to be absent --
path : /path/to/existing-link-file
--
```

### `assert_block_not_exist`

Fail if the given block special file exists.

```bash
@test 'assert_block_not_exist() {
  assert_file_not_exist /path/to/existing-block-file
}
```

On failure, the path is displayed.

```
-- block special file exists, but it was expected to be absent --
path : /path/to/existing-block-file
--
```

### `assert_character_not_exist`

Fail if the given character special file exists.

```bash
@test 'assert_character_not_exist() {
  assert_file_not_exist /path/to/existing-character-file
}
```

On failure, the path is displayed.

```
-- character special file exists, but it was expected to be absent --
path : /path/to/existing-character-file
--
```

### `assert_socket_not_exist`

Fail if the given socket exists.

```bash
@test 'assert_socket_not_exist() {
  assert_file_not_exist /path/to/existing-socket
}
```

On failure, the path is displayed.

```
-- socket exists, but it was expected to be absent --
path : /path/to/existing-socket
--
```

### `assert_fifo_not_exist`

Fail if the given named pipe exists.

```bash
@test 'assert_fifo_not_exist()' {
  assert_file_not_exist /path/to/existing-fifo-file
}
```

On failure, the path is displayed.

```
-- named pipe exists, but it was expected to be absent --
path : /path/to/existing-fifo-file
--
```


### `assert_file_not_executable`

Fail if the given file is executable.

```bash
@test 'assert_file_not_executable()' {
  assert_file_not_executable /path/to/executable-file
}
```

On failure, the path is displayed.

```
-- file is executable, but it was expected to be not executable --
path : /path/to/executable-file
--
```


### `assert_files_not_equal`

Fail if the given files are the same.

```bash
@test 'assert_files_not_equal()' {
  assert_files_not_equal /path/to/file1 /path/to/file2
}
```

On failure, the path is displayed.

```
-- files are the same --
path1 : /path/to/file
path2 : /path/to/same_file
--
```

### `assert_not_symlink_to`
Fail if the given file is a symbolic to a defined target.
```bash
@test 'assert_not_symlink_to() {
  assert_not_symlink_to /path/to/source-file /path/to/symlink
}
```
On failure, the path is displayed.
```
-- file is a symbolic link --
path : /path/to/symlink
--
-- symbolic link does have the correct target --
path : /path/to/symlink
--
```

## Working with temporary directories

When testing code that manipulates the filesystem, it is good practice
to run tests in clean, throw-away environments to ensure correctness and
reproducibility. Therefore, this library includes convenient functions
to create and destroy temporary directories.


### `temp_make`

Create a temporary directory for the current test in `BATS_TMPDIR`. The
directory is guaranteed to be unique and its name is derived from the
test's filename and number for easy identification.

```
<test-filename>-<test-number>-<random-string>
```

This information is only available in `setup`, `@test` and `teardown`,
thus the function must be called from one of these locations.

The path of the directory is displayed on the standard output and is
meant to be captured into a variable.

```bash
setup() {
  TEST_TEMP_DIR="$(temp_make)"
}
```

For example, for the first test in `sample.bats`, this snippet creates a
directory named `sample.bats-1-XXXXXXXXXX`, where each trailing `X` is a
random alphanumeric character.

If the directory cannot be created, the function fails and displays an
error message on the standard error.

```
-- ERROR: temp_make --
mktemp: failed to create directory via template ‘/etc/samle.bats-1-XXXXXXXXXX’: Permission denied
--
```

#### Directory name prefix

The directory name can be prefixed with an arbitrary string using the `--prefix
<prefix>` option (`-p <prefix>` for short).

```bash
setup() {
  TEST_TEMP_DIR="$(temp_make --prefix 'myapp-')"
}
```

Following the previous example, this will create a directory named
`myapp-sample.bats-1-XXXXXXXXXX`. This can be used to group temporary
directories.

Generally speaking, the directory name is of the following form.

```
<prefix><test-filename>-<test-number>-<random-string>
```


### `temp_del`

Delete a temporary directory, typically created with `temp_make`.

```bash
teardown() {
  temp_del "$TEST_TEMP_DIR"
}
```

If the directory cannot be deleted, the function fails and displays an
error message on the standard error.

```
-- ERROR: temp_del --
rm: cannot remove '/etc/samle.bats-1-04RUVmBP7x': No such file or directory
--
```

_**Note:** Actually, this function can be used to delete any file or
directory. However, it is most useful in deleting temporary directories
created with `temp_make`, hence the naming._

#### Preserve directory

During development, it is useful to peak into temporary directories
post-mortem to see what the tested code has done.

When `BATSLIB_TEMP_PRESERVE` is set to 1, the function succeeds but the
directory is not deleted.

```bash
$ BATSLIB_TEMP_PRESERVE=1 bats sample.bats
```

#### Preserve directory on failure

During debugging, it is useful to preserve the temporary directories of
failing tests.

When `BATSLIB_TEMP_PRESERVE_ON_FAILURE` is set to 1, the function
succeeds but the directory is not deleted if the test has failed.

```bash
$ BATSLIB_TEMP_PRESERVE_ON_FAILURE=1 bats sample.bats
```

The outcome of a test is only known in `teardown`, therefore this
feature can be used only when `temp_del` is called from that location.
Otherwise and error is displayed on the standard error.


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
the end, prepend `#` or `%`, respectively.

For example, the following example hides the path of the temporary
directory where the test takes place.

```bash
setup {
  TEST_TEMP_DIR="$(temp_make)"
  BATSLIB_FILE_PATH_REM="#${TEST_TEMP_DIR}"
  BATSLIB_FILE_PATH_ADD='<temp>'
}

@test 'assert_file_exist()' {
  assert_file_exist "${TEST_TEMP_DIR}/path/to/non-existent-file"
}

teardown() {
  temp_del "$TEST_TEMP_DIR"
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
