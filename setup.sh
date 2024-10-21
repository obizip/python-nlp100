#!/usr/bin/env bash

mkdir -p data
cd data

if [ ! -f "neko.txt" ]; then
    wget https://nlp100.github.io/data/neko.txt
fi

if ! command -v mecab 2>&1 >/dev/null; then
	echo "mecab is not available"
	exit 1
fi

if [ ! -f "neko.txt.mecab" ]; then
	mecab neko.txt -o neko.txt.mecab
fi

if [ ! -f "ai.ja.txt" ]; then
    wget "https://nlp100.github.io/data/ai.ja.zip"
    unzip "ai.ja.zip"
    rm "ai.ja.zip"
fi

if ! command -v cabocha 2>&1 >/dev/null; then
	echo "cabocha is not available"
	exit 1
fi

if [ ! -f "ai.ja.txt.parsed" ]; then
    cabocha "ai.ja.txt" -o "ai.ja.txt.parsed"
fi
