#!/usr/bin/env bats

load 'test_helper'
fixtures 'exist'

# Correctness
@test 'assert_not_zero() <file>: returns 0 if <file> file is greater than 0 byte' {
  local -r file="${TEST_FIXTURE_ROOT}/dir/notzerobyte"
  run assert_not_zero "$file"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 0 ]
}

@test 'assert_not_zero() <file>: returns 1 and displays path if <file> file is 0 byte, but it was expected not to be' {
  local -r file="${TEST_FIXTURE_ROOT}/dir/zerobyte"
  run assert_not_zero "$file"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- file is 0 byte, but it was expected not to be --' ]
  [ "${lines[1]}" == "path : $file" ]
  [ "${lines[2]}" == '--' ]
}


# Transforming path
@test 'assert_not_zero() <file>: replace prefix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM="#${TEST_FIXTURE_ROOT}"
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_not_zero "${TEST_FIXTURE_ROOT}/dir/zerobyte"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- file is 0 byte, but it was expected not to be --' ]
  [ "${lines[1]}" == "path : ../dir/zerobyte" ]
  [ "${lines[2]}" == '--' ]
}

@test 'assert_not_zero() <file>: replace suffix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM='%dir/zerobyte'
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_not_zero "${TEST_FIXTURE_ROOT}/dir/zerobyte"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- file is 0 byte, but it was expected not to be --' ]
  [ "${lines[1]}" == "path : ${TEST_FIXTURE_ROOT}/.." ]
  [ "${lines[2]}" == '--' ]
}

@test 'assert_not_zero() <file>: replace infix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM='dir/zerobyte'
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_not_zero "${TEST_FIXTURE_ROOT}/dir/zerobyte"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- file is 0 byte, but it was expected not to be --' ]
  [ "${lines[1]}" == "path : ${TEST_FIXTURE_ROOT}/.." ]
  [ "${lines[2]}" == '--' ]
}
