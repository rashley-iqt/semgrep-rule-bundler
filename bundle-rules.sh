#!/bin/sh

[[ ! -d "./rules" ]] && mkdir "rules"

docker build -t semgrep-rule-bundler .

for lang in $(cat langs.txt)
do
	echo "Creating rules for $lang"
	docker run --rm -v "$(pwd)/rules:/output" semgrep-rule-bundler "$lang" -o "/output/semgrep-$lang.yml"
done