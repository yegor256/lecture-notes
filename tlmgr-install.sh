#!/usr/bin/env bash

# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex -o pipefail

self=$(dirname "$0")

tlmgr option repository ctan
tlmgr --verify-repo=none update --self

deps="${self}/DEPENDS.txt"
if [ ! -e "${deps}" ]; then
    echo "The file with dependencies is absent, why?"
    echo "Expecting it to be here: ${deps}"
    exit 1
fi
packages=()
while IFS=' ' read -r p; do
    packages+=("${p}")
done < <(cut -d' ' -f2 "${deps}" | uniq)

tlmgr --verify-repo=none install "${packages[@]}"
tlmgr --verify-repo=none update "${packages[@]}"
