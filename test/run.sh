#!/bin/bash
#!/usr/bin/env sh

set -euo pipefail

if (( $# < 1 )); then
    echo "Usage: $0 <testcase_directory>..." >&2
    exit 1
fi

while (( $# > 0 )); do
    dir_testcase="${1}"
    shift

    file_cmd="${dir_testcase}/cmds.vim"
    file_in="${dir_testcase}/input.txt"
    file_out="${dir_testcase}/output.txt"
    file_exp="${dir_testcase}/expected.txt"

    cp -v "${file_in}" "${file_out}"

    cat >"${file_cmd}" <<EOF
:set foldmethod=marker
:%call SortFolds#SortFolds()
:messages
:wq
EOF

    true > messages.log

    ${EDITOR} -V0messages.log -s "${file_cmd}" "${file_out}" 2>&1

    rm "${file_cmd}"

    if diff "${file_out}" "${file_exp}"; then
        exit 0
    else
        echo "TEST FAILED" >&2
        cat messages.log >&2
        exit 1
    fi
done