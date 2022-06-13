import argparse
import os
import re
import sys

from ruamel.yaml import YAML

yaml=YAML(typ='safe')
yaml.default_flow_style = False

def setup():
    parser = argparse.ArgumentParser()
    parser.add_argument("-o", "--outfile", help="file to write collected rules to.", required=False)
    parser.add_argument("path", help="Path to recursively pull rules from")
    args = parser.parse_args()
    return args

def get_rules_on_path(path, rules):
    for root, dirs, files in os.walk(path):
        print(f"file count: {len(files)}")
        for filename in files:
            full_path = os.path.join(root,filename)
            if re.search("[^\.test]\.ya?ml$", filename):
                with open(full_path, 'r') as stream:
                    print(f"loading rules from {filename}")
                    content = yaml.load(stream)
                    if content and content['rules']:
                        for rule in content['rules']:
                            rules.append(rule)
                    
    # yaml.dump(rules, sys.stdout)

def main():
    args = setup()
    outfile = args.outfile
    path = os.path.join("/bundler/rules/",args.path)
    
    # directory = "output/" + organization
    # if not os.path.exists(directory):
    #     os.makedirs(directory)
    print(f"Writing rules to {outfile}")
    try:
        rules = list()
        print(f"Gathering rules from path: {path} \n\n")
        get_rules_on_path(path, rules)
        final = {'rules': rules}
        if outfile:
            with open(outfile, 'w') as stream:
                yaml.dump(final, stream)
        else:
            yaml.dump(final, sys.stdout)

    except Exception as e:
        print(e)


if __name__ == '__main__':
    main()