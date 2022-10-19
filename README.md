# Semgrep rule bundler

This tool is used for situations where it is impossible or undesireable to use the auto config of semgrep to automatically select rules. This tool instead pulls from [returntocorp's repository of semgrep rules](https://github.com/returntocorp/semgrep-rules) and then allows a user to specify a directory of rules to package together into a single rules file for convenient usage.

## Usage
### Docker
```sh
docker build -t semgrep-rule-bundler .
docker run --rm -v "$(pwd)/rules:/output" semgrep-rule-bundler <directory_name> -o "/output/semgrep-rules.yml"
```
### Convenience script
Because may projects contain multiple languuages and may require multiple rulesets, a convenience script has been provided. To use it simply fill in the file `langs.txt` with the appropriate list of a languages (technically they need to correspond to the directory structure of the rules repo) and invoke the script

```sh
./bundle-rules.sh
```