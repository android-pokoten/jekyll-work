#!/bin/bash

SRC_DIR="assets/images"
DST_DIR="assets/thumbs"

# 引数チェック
if [ $# -eq 0 ]; then
  echo "Usage: $0 assets/images/YYYY/MM/"
  exit 1
fi

INPUT_DIR="$1"

# 画像拡張子（必要に応じて追加）
EXTENSIONS="jpg jpeg png webp"

# 再帰的に SRC_DIR を走査
find "$INPUT_DIR" -type f | while read -r img; do
  # 拡張子チェック
  ext="${img##*.}"
  ext_lower=$(echo "$ext" | tr 'A-Z' 'a-z')
  if ! echo "$EXTENSIONS" | grep -qw "$ext_lower"; then
    continue
  fi

  # 相対パス生成
  relpath="${img#$SRC_DIR/}"     # 例: 2026/01/ss-001.jpg
  outdir="$DST_DIR/$(dirname "$relpath")"
  outfile="$outdir/$(basename "$img")"

  # 出力先ディレクトリ作成
  mkdir -p "$outdir"

  # 既にサムネイルがある場合はスキップ
  if [ -f "$outfile" ]; then
    echo "skip: $outfile"
    continue
  fi

  # サムネイル生成
  echo "create: $outfile"
  convert "$img" -resize 1200x1200 "$outfile"
done
