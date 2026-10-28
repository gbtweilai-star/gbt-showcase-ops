#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PYTHONPATH=src python -m gbt_showcase_ops info
PYTHONPATH=src python -m gbt_showcase_ops check --payload '{}'
PYTHONPATH=src python -m gbt_showcase_ops run   --payload '{}'
