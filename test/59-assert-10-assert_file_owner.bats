#!/usr/bin/env bats

load 'test_helper'
fixtures 'exist'


# Correctness
@test 'assert_file_owner() <file>: returns 0 if <file> user is the owner of the file' {
  local -r file="${TEST_FIXTURE_ROOT}/dir/owner"
  run assert_file_owner "$file"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 0 ]
}

@test 'assert_file_owner() <file>: returns 1 and displays path if <file> user is not the owner of the file' {
  local -r file="${TEST_FIXTURE_ROOT}/dir/notowner"
  run assert_file_owner "$file"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- user is not the owner of the file --' ]
  [ "${lines[1]}" == "path : $file" ]
  [ "${lines[2]}" == '--' ]
}



# Transforming path
@test 'assert_file_owner() <file>: replace prefix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM="#${TEST_FIXTURE_ROOT}"
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_file_owner "${TEST_FIXTURE_ROOT}/dir/notowner"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- user is not the owner of the file --' ]
  [ "${lines[1]}" == "path : ../dir/notowner" ]
  [ "${lines[2]}" == '--' ]
}

@test 'assert_file_owner() <file>: replace suffix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM='%dir/notowner'
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_file_owner "${TEST_FIXTURE_ROOT}/dir/notowner"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- user is not the owner of the file --' ]
  [ "${lines[1]}" == "path : ${TEST_FIXTURE_ROOT}/.." ]
  [ "${lines[2]}" == '--' ]
}

@test 'assert_file_owner() <file>: replace infix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM='dir/notowner'
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_file_owner "${TEST_FIXTURE_ROOT}/dir/notowner"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- user is not the owner of the file --' ]
  [ "${lines[1]}" == "path : ${TEST_FIXTURE_ROOT}/.." ]
  [ "${lines[2]}" == '--' ]
}
