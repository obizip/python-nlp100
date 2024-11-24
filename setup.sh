#!/usr/bin/env bash

mkdir -p data
cd data

if [ ! -f "popular-names.txt" ]; then
    wget "https://nlp100.github.io/data/popular-names.txt"
fi

if [ ! -f "jawiki-country.json" ]; then
    wget "https://nlp100.github.io/data/jawiki-country.json.gz"
    gzip -d "jawiki-country.json.gz"
fi

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
    mecab ai.ja.txt | cabocha -I1 -O2 | cabocha -I2 -O3 | cabocha -f1 -I3 -O4 -o ai.ja.txt.parsed

fi

if [ ! -f "ch5_example.parsed" ]; then
    echo "ジョン・マッカーシーはAIに関する最初の会議で人工知能という用語を作り出した。" | mecab | cabocha -I1 -O2 | cabocha -I2 -O3 | cabocha -f1 -I3 -O4 -o "ch5_example.parsed"
fi

if [ ! -f "ch5-47.parsed" ]; then
    echo "また、自らの経験を元に学習を行う強化学習という手法もある。" | mecab | cabocha -I1 -O2 | cabocha -I2 -O3 | cabocha -f1 -I3 -O4 -o "ch5-47.parsed"
fi

if [ ! -f "news+aggregator.zip" ]; then
    wget https://archive.ics.uci.edu/static/public/359/news+aggregator.zip
    mkdir -p news
    unzip news+aggregator.zip -d news
fi