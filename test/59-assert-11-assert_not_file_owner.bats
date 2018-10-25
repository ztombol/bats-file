#!/usr/bin/env bats

load 'test_helper'
fixtures 'exist'

# Correctness
@test 'assert_not_file_owner() <file>: returns 0 if <file> user is not the owner' {
  local -r file="${TEST_FIXTURE_ROOT}/dir/notowner"
  run assert_not_file_owner "$file"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 0 ]
}

@test 'assert_not_file_owner() <file>: returns 1 and displays path if <file> user is the owner, but it was expected not to be' {
  local -r file="${TEST_FIXTURE_ROOT}/dir/owner"
  run assert_not_file_owner "$file"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- user is the owner, but it was expected not to be --' ]
  [ "${lines[1]}" == "path : $file" ]
  [ "${lines[2]}" == '--' ]
}


# Transforming path
@test 'assert_not_file_owner() <file>: replace prefix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM="#${TEST_FIXTURE_ROOT}"
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_not_file_owner "${TEST_FIXTURE_ROOT}/dir/owner"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- user is the owner, but it was expected not to be --' ]
  [ "${lines[1]}" == "path : ../dir/owner" ]
  [ "${lines[2]}" == '--' ]
}

@test 'assert_not_file_owner() <file>: replace suffix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM='%dir/owner'
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_not_file_owner "${TEST_FIXTURE_ROOT}/dir/owner"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- user is the owner, but it was expected not to be --' ]
  [ "${lines[1]}" == "path : ${TEST_FIXTURE_ROOT}/.." ]
  [ "${lines[2]}" == '--' ]
}

@test 'assert_not_file_owner() <file>: replace infix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM='dir/owner'
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_not_file_owner "${TEST_FIXTURE_ROOT}/dir/owner"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- user is the owner, but it was expected not to be --' ]
  [ "${lines[1]}" == "path : ${TEST_FIXTURE_ROOT}/.." ]
  [ "${lines[2]}" == '--' ]
}
