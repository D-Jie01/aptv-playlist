#!/bin/sh
set -eu

playlist="cqcu-unicast.m3u"
source_url="http://82.156.243.185:33389/fwc.m3u"
start_marker="# ===== 世界杯自动更新开始 ====="
end_marker="# ===== 世界杯自动更新结束 ====="
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

curl --fail --location --silent --show-error --max-time 30 \
  "$source_url" > "$tmp_dir/world-cup.m3u"

grep -q '^#EXTM3U' "$tmp_dir/world-cup.m3u"
grep -q '^#EXTINF' "$tmp_dir/world-cup.m3u"

awk -v start="$start_marker" -v end="$end_marker" '
  $0 == start { skip = 1; next }
  $0 == end { skip = 0; next }
  !skip { print }
' "$playlist" > "$tmp_dir/base.m3u"

awk '
  /^#EXTM3U/ { next }
  /^#EXTINF/ {
    if ($0 ~ /group-title="/) {
      sub(/group-title="/, "group-title=\"世界杯专用 · ")
    } else {
      sub(/,/, " group-title=\"世界杯专用\",")
    }
  }
  { print }
' "$tmp_dir/world-cup.m3u" > "$tmp_dir/tagged.m3u"

{
  sed -e ':a' -e '/^$/{$d;N;ba' -e '}' "$tmp_dir/base.m3u"
  printf '\n%s\n' "$start_marker"
  cat "$tmp_dir/tagged.m3u"
  printf '%s\n' "$end_marker"
} > "$playlist"
