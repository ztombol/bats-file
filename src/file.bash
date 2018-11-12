#
# bats-file - Common filesystem assertions and helpers for Bats
#
# Written in 2016 by Zoltan Tombol <zoltan dot tombol at gmail dot com>
#
# To the extent possible under law, the author(s) have dedicated all
# copyright and related and neighboring rights to this software to the
# public domain worldwide. This software is distributed without any
# warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication
# along with this software. If not, see
# <http://creativecommons.org/publicdomain/zero/1.0/>.
#

#
# file.bash
# ---------
#
# Assertions are functions that perform a test and output relevant
# information on failure to help debugging. They return 1 on failure
# and 0 otherwise.
#
# All output is formatted for readability using the functions of
# `output.bash' and sent to the standard error.
#

# Fail and display path of the file or directory if it does not exist.
# This function is the logical complement of `assert_not_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - file or directory exists
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_exist() {
  local -r file="$1"
  if [[ ! -e "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'file or directory does not exist' \
      | fail
  fi
}

# Fail and display path of the file if it does not exist.
# This function is the logical complement of `assert_file_not_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - file exists
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_file_exist() {
  local -r file="$1"
  if [[ ! -f "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'file does not exist' \
      | fail
  fi
}

# Fail and display path of the directory if it does not exist.
# This function is the logical complement of `assert_dir_not_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - directory exists
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_dir_exist() {
  local -r file="$1"
  if [[ ! -d "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'directory does not exist' \
      | fail
  fi
}

# Fail and display path of the block special file if it does not exist.
# This function is the logical complement of `assert_block_not_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - block special file exists
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_block_exist() {
  local -r file="$1"
  if [[ ! -b "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'block special file does not exist' \
      | fail
  fi
}

# Fail and display path of the character special file if it does not exist.
# This function is the logical complement of `assert_character_not_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - character special file exists
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_character_exist() {
  local -r file="$1"
  if [[ ! -c "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'character special file does not exist' \
      | fail
  fi
}

# Fail and display path of the symbolic link if it does not exist.
# This function is the logical complement of `assert_link_not_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - symbolic link exists
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_link_exist() {
  local -r file="$1"
  if [[ ! -L "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'symbolic link does not exist' \
      | fail
  fi
}

# Fail and display path of the socket if it does not exist.
# This function is the logical complement of `assert_socket_not_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - socket exists
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_socket_exist() {
  local -r file="$1"
  if [[ ! -S "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'socket does not exist' \
      | fail
  fi
}

# Fail and display path of the named pipe if it does not exist.
# This function is the logical complement of `assert_fifo_not_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - named pipe exists
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_fifo_exist() {
  local -r file="$1"
  if [[ ! -p "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'fifo does not exist' \
      | fail
  fi
}

# Fail and display path of the named file if it is not executable.
# This function is the logical complement of `assert_file_not_executable'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - named pipe exists
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_file_executable() {

  local -r file="$1"
  if [[ ! -x "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'file is not executable' \
      | fail
  fi
}

# This function is the logical complement of `assert_files_not_equal'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - 1st path
#   $2 - 2nd path
# Returns:
#   0 - named files are the same
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_files_equal() {
  local -r file1="$1"
  local -r file2="$2"
  if ! `cmp -s "$file1" "$file2"` ; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file1/$rem/$add}" 'path' "${file2/$rem/$add}" \
      | batslib_decorate 'files are not the same' \
      | fail
  fi
}

# Fail and display path of the file (or directory) if it exists. This
# function is the logical complement of `assert_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - file does not exist
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_not_exist() {
  local -r file="$1"
  if [[ -e "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'file or directory exists, but it was expected to be absent' \
      | fail
  fi
}

# Fail and display path of the file if it exists. This
# function is the logical complement of `assert_file_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - file does not exist
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_file_not_exist() {
  local -r file="$1"
  if [[ -f "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'file exists, but it was expected to be absent' \
      | fail
  fi
}

# Fail and display path of the directory if it exists. This
# function is the logical complement of `assert_dir_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - directory does not exist
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_dir_not_exist() {
  local -r file="$1"
  if [[ -d "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'directory exists, but it was expected to be absent' \
      | fail
  fi
}

# Fail and display path of the block special file if it exists. This
# function is the logical complement of `assert_block_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - block special file does not exist
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_block_not_exist() {
  local -r file="$1"
  if [[ -b "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'block special file exists, but it was expected to be absent' \
      | fail
  fi
}

# Fail and display path of the character special file if it exists. This
# function is the logical complement of `assert_character_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - character special file does not exist
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_character_not_exist() {
  local -r file="$1"
  if [[ -c "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'character special file exists, but it was expected to be absent' \
      | fail
  fi
}

# Fail and display path of the symbolic link if it exists. This
# function is the logical complement of `assert_link_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - symbolic link does not exist
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_link_not_exist() {
  local -r file="$1"
  if [[ -L "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'symbolic link exists, but it was expected to be absent' \
      | fail
  fi
}

# Fail and display path of the socket if it exists. This
# function is the logical complement of `assert_socket_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - socket does not exist
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_socket_not_exist() {
  local -r file="$1"
  if [[ -S "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'socket exists, but it was expected to be absent' \
      | fail
  fi
}

# Fail and display path of the named pipe if it exists. This
# function is the logical complement of `assert_fifo_exist'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - named pipe does not exist
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_fifo_not_exist() {
  local -r file="$1"
  if [[ -p "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'fifo exists, but it was expected to be absent' \
      | fail
  fi
}





# Fail and display path of the named file if it is executable. This
# function is the logical complement of `assert_file_executable'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - path
# Returns:
#   0 - named pipe does not exist
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_file_not_executable() {
  local -r file="$1"
  if [[ -x "$file" ]]; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file/$rem/$add}" \
      | batslib_decorate 'file is executable, but it was expected to be not executable' \
      | fail
  fi
}

# This function is the logical complement of `assert_files_equal'.
#
# Globals:
#   BATSLIB_FILE_PATH_REM
#   BATSLIB_FILE_PATH_ADD
# Arguments:
#   $1 - 1st path
#   $2 - 2nd path
# Returns:
#   0 - named files are the same
#   1 - otherwise
# Outputs:
#   STDERR - details, on failure
assert_files_not_equal() {
  local -r file1="$1"
  local -r file2="$2"
  if `cmp -s "$file1" "$file2"` ; then
    local -r rem="$BATSLIB_FILE_PATH_REM"
    local -r add="$BATSLIB_FILE_PATH_ADD"
    batslib_print_kv_single 4 'path' "${file1/$rem/$add}" 'path' "${file2/$rem/$add}" \
      | batslib_decorate 'files are the same' \
      | fail
  fi
}
