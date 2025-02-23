#!/bin/bash

# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

set -ex

self=$(dirname "$0")

tlmgr option repository ctan
tlmgr --verify-repo=none update --self

IFS=', ' read -r -a packages <<< "$(cut -d' ' -f2 "${self}/DEPENDS.txt" | uniq)"

tlmgr --verify-repo=none install "${packages[@]}"
tlmgr --verify-repo=none update "${packages[@]}"
