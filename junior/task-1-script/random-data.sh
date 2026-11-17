#!/usr/bin/env bash
set -euo pipefail

bytes_base64=$(openssl rand 10 | base64)
bytes_count=$(printf '%s' "$bytes_base64" | base64 -d | wc -c)
bytes_base64_count=$(printf '%s' "$bytes_base64" | wc -c)
combined_count=$((bytes_count + bytes_base64_count))

echo "Combined count: $combined_count"
echo "Bytes count: $bytes_count"
echo "Bytes base64: $bytes_base64"
echo "Bytes base64 count: $bytes_base64_count"
