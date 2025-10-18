#!/bin/bash

# 2MB 以上の画像ファイルを変換して、1200ピクセル以下、画質85、メタデータを削除してサイズを減らす
TARGET_DIR="./"

find "$TARGET_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" \) | while read -r file; do
  FILESIZE=$(stat -c%s "$file")

  if [ "$FILESIZE" -ge 2000000 ]; then
    echo "🛠 $file を圧縮中..."

    mogrify -resize "1200x1200>" \
            -quality 85 \
            "$file"
  fi
done

echo "上書き完了！"

