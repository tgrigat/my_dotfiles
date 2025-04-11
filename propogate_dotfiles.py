# pylint: disable=invalid-name, line-too-long, missing-docstring, redefined-outer-name
"""Propogate my dotfiles in the repo, 
they are symlinked to destinations defined in destinations.yaml"""

import os
import argparse
from typing import Dict, List, Any
from os.path import join, isdir, isfile, islink
import shutil
import yaml

wkdir = os.getcwd()
user = os.environ.get("USER")

repo = wkdir
home = os.environ.get("HOME")
dot_config = f"{home}/.config"

to_ignore = [
    ".git",
    "dotflie.py",
    "confsync",
    "destination.yaml",
    ".gitignore",
    "README.md",
    "propogate_dotfiles.py",
    ".session",
    "kde_backup.py",
    ".gitconfig",
]


# Read the destinations from the destination.yaml file
def read_destinations(file: str) -> Dict[str, str]:
    with open(file, "r", encoding="utf-8") as f:
        return yaml.safe_load(f)


destinations = read_destinations("destination.yaml")

all_configs = [config for config in os.listdir(repo) if config not in to_ignore]


def remove(path):
    if os.path.isfile(path) or os.path.islink(path):
        os.remove(path)
    elif os.path.isdir(path):
        shutil.rmtree(path)
    else:
        raise ValueError(f"file {path} is not a file or dir.")


def create_link(
    config_dir: str, target_dir: str, configs: List[str], safe_mode: Any = True
) -> None:
    for cfg in configs:
        target_dir_expanded = os.path.expanduser(target_dir)

        if isdir(join(target_dir_expanded, cfg)) or isfile(
            join(target_dir_expanded, cfg)
        ):
            if islink(join(target_dir_expanded, cfg)):
                continue

            if safe_mode:
                raise NotImplementedError(
                    f"{cfg} already exists at {target_dir_expanded}, please remove it manually"
                )
            else:
                remove(join(target_dir_expanded, cfg))
                print(f"Warning: removed {cfg} in {target_dir_expanded}")

        try:
            os.symlink(join(config_dir, cfg), target_dir_expanded)
        except FileExistsError:
            print(f"Warning: {cfg} already exists at {target_dir_expanded}")
        except FileNotFoundError:
            os.makedirs(target_dir_expanded)
            print(
                f"Warning: {cfg} not found in {config_dir}, created for now. "
                "Please rerun to make it happen!"
            )
        print(f"Link {cfg} to target")


# def scan_for_unknown(config_dir: str, configs: List) -> None:
#     for item in os.listdir(config_dir):
#         if islink(join(config_dir, item)) and item not in configs:
#             print(
#                 f"Warning: {item} in ~/.config is a symlink but not in config file. Please check if this is a discarded config."
#             )


def main():
    parser = argparse.ArgumentParser(description='Propagate dotfiles from repo to destinations')
    parser.add_argument('configs', nargs='*', help='Specific configs to propagate (leave empty for all)')
    args = parser.parse_args()

    if args.configs:
        # Only propagate specified configs
        configs_to_propagate = []
        for config in args.configs:
            if config in destinations:
                configs_to_propagate.append(config)
            else:
                print(f"Warning: {config} not found in destination.yaml, skipping")
        
        if not configs_to_propagate:
            print("No valid configs specified, nothing to do")
            return
    else:
        # Propagate all configs (original behavior)
        configs_to_propagate = all_configs

    for config in configs_to_propagate:
        target_dir = destinations.get(config)
        if target_dir:
            create_link(repo, target_dir, [config], safe_mode=False)
        else:
            print(f"Warning: {config} not found in destination.yaml")

    print("Finished the linking process")

if __name__ == "__main__":
    main()
