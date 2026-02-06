#!/bin/bash

SRC_DIR="assets/images"
DST_DIR="assets/thumbs"

if [ $# -eq 0 ]; then
  echo "Usage: $0 assets/images/YYYY/MM/filename.jpg"
  exit 1
fi

img="$1"

# パスチェック
if [ ! -f "$img" ]; then
  echo "Error: file not found: $img"
  exit 1
fi

relpath="${img#$SRC_DIR/}"        # 2026/01/ss-001.jpg
dirpath=$(dirname "$relpath")     # 2026/01
filename=$(basename "$img")       # ss-001.jpg

outdir="$DST_DIR/$dirpath"
outfile="$outdir/$filename"

mkdir -p "$outdir"

#cp $img $outfile
#mogrify -resize 1200x1200 $outfile
convert "$img" -resize 1200x1200 "$outfile"
echo "→ created: $outfile"
