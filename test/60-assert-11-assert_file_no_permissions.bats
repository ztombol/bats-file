#!/usr/bin/env bats

load 'test_helper'
fixtures 'exist'

# Correctness
@test 'assert_no_file_permission() <file>: returns 0 if <file> file does not have permissions 777' {
  local -r file="${TEST_FIXTURE_ROOT}/dir/nopermission"
  run assert_no_file_permission "$file"
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 0 ]
}

@test 'assert_no_file_permission() <file>: returns 1 and displays path if <file> file has permissions 777, but it was expected not to have' {
  local -r file="${TEST_FIXTURE_ROOT}/dir/permission"
  run assert_no_file_permission "$file"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- file has permissions 777, but it was expected not to have --' ]
  [ "${lines[1]}" == "path : $file" ]
  [ "${lines[2]}" == '--' ]
}


# Transforming path
@test 'assert_no_file_permission() <file>: replace prefix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM="#${TEST_FIXTURE_ROOT}"
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_no_file_permission "${TEST_FIXTURE_ROOT}/dir/permission"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- file has permissions 777, but it was expected not to have --' ]
  [ "${lines[1]}" == "path : ../dir/permission" ]
  [ "${lines[2]}" == '--' ]
}

@test 'assert_no_file_permission() <file>: replace suffix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM='%dir/permission'
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_no_file_permission "${TEST_FIXTURE_ROOT}/dir/permission"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- file has permissions 777, but it was expected not to have --' ]
  [ "${lines[1]}" == "path : ${TEST_FIXTURE_ROOT}/.." ]
  [ "${lines[2]}" == '--' ]
}

@test 'assert_no_file_permission() <file>: replace infix of displayed path' {
  local -r BATSLIB_FILE_PATH_REM='dir/permission'
  local -r BATSLIB_FILE_PATH_ADD='..'
  run assert_no_file_permission "${TEST_FIXTURE_ROOT}/dir/permission"
  [ "$status" -eq 1 ]
  [ "${#lines[@]}" -eq 3 ]
  [ "${lines[0]}" == '-- file has permissions 777, but it was expected not to have --' ]
  [ "${lines[1]}" == "path : ${TEST_FIXTURE_ROOT}/.." ]
  [ "${lines[2]}" == '--' ]
}
