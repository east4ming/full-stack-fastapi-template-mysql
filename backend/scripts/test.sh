#!/usr/bin/env bash

set -e
set -x

# 如果存在 rye 命令， 就执行 rye run pytest
# 否则执行 pytest
if rye version &>/dev/null; then
    rye run coverage run --source=src/app -m pytest
    rye run coverage report --show-missing
    rye run coverage html --title "${@-coverage}"
else
    coverage run --source=src/app -m pytest
    coverage report --show-missing
    coverage html --title "${@-coverage}"
fi
