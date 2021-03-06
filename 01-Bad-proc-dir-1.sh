source "${TEST_DIR}/lib/funcs.bash"

test_start "Invalid /proc directory" \
"If the directory given for -p is invalid, print an error message and exit.
Return EXIT_FAILURE or similar. Test fails if return = 0 or segfault."

output=$(./inspector -o -p /this/directory/does/not/exist)

# We should not find any inspector output because the program should quit. If we
# do, the test fails:
grep "Hostname" <<< "${output}" &> /dev/null && test_end 1
grep "Uptime" <<< "${output}" &> /dev/null && test_end 1
grep "Load Average" <<< "${output}" &> /dev/null && test_end 1

return_value="${?}"
[[ ${return_value} -ne 0 && ${return_value} -ne 139 ]];
test_end

