#!/bin/bash

SPDX_IDENTIFIER="// SPDX-FileCopyrightText: 2023 Marigold <contact@marigold.dev>
//
// SPDX-License-Identifier: MIT
"

for file in $(find . -type f -name "*.rs"); do
ed -s "${file}" <<EOF >/dev/null
1
i
${SPDX_IDENTIFIER}
.
w
q
EOF
done 
