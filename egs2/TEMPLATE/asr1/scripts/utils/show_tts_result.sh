#!/usr/bin/env bash
mindepth=0
maxdepth=10

. utils/parse_options.sh

if [ $# -gt 1 ]; then
    echo "Usage: $0 --mindepth 0 --maxdepth 1 [exp]" 1>&2
    echo ""
    echo "Show the system environments and the evaluation results in Markdown format."
    echo 'The default of <exp> is "exp/".'
    exit 1
fi

[ -f ./path.sh ] && . ./path.sh
set -euo pipefail
if [ $# -eq 1 ]; then
    exp=$1
else
    exp=exp
fi


cat << EOF
<!-- Generated by $0 -->
# RESULTS
## Environments
- date: \`$(LC_ALL=C date)\`
EOF

python3 << EOF
import sys, espnet, torch
pyversion = sys.version.replace('\n', ' ')

print(f"""- python version: \`{pyversion}\`
- espnet version: \`espnet {espnet.__version__}\`
- pytorch version: \`pytorch {torch.__version__}\`""")
EOF

cat << EOF
- Git hash: \`$(git rev-parse HEAD)\`
  - Commit date: \`$(git log -1 --format='%cd')\`

EOF

