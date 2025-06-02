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

# Core configs that will be propagated with --core flag
core_configs = ["nvim", "zellij", "fish", "btop", "yazi", "lazygit"]


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
) -> Dict[str, List[str]]:
    """Returns a dict with 'success', 'warnings', 'errors' keys containing lists of messages"""
    results = {'success': [], 'warnings': [], 'errors': []}
    
    for cfg in configs:
        target_dir_expanded = os.path.expanduser(target_dir)
        target_path = join(target_dir_expanded, cfg)
        source_path = join(config_dir, cfg)

        try:
            # Check if target already exists
            if islink(target_path):
                results['warnings'].append(f"{cfg}: already linked at {target_dir_expanded}")
                continue
            elif isdir(target_path) or isfile(target_path):
                if safe_mode:
                    results['errors'].append(f"{cfg}: target exists at {target_dir_expanded}")
                    continue
                else:
                    remove(target_path)
                    results['warnings'].append(f"{cfg}: removed existing file/dir at {target_dir_expanded}")

            # Create target directory if needed
            if not os.path.exists(target_dir_expanded):
                os.makedirs(target_dir_expanded)
                results['warnings'].append(f"Created directory: {target_dir_expanded}")

            # Create the symlink
            os.symlink(source_path, target_path)
            results['success'].append(f"{cfg} → {target_dir_expanded}")

        except FileExistsError:
            results['warnings'].append(f"{cfg}: already exists at {target_dir_expanded}")
        except Exception as e:
            results['errors'].append(f"{cfg}: failed to link - {str(e)}")

    return results


# def scan_for_unknown(config_dir: str, configs: List) -> None:
#     for item in os.listdir(config_dir):
#         if islink(join(config_dir, item)) and item not in configs:
#             print(
#                 f"Warning: {item} in ~/.config is a symlink but not in config file. Please check if this is a discarded config."
#             )


def print_summary(all_results: List[Dict[str, List[str]]]):
    """Print a clean summary of all operations"""
    total_success = sum(len(r['success']) for r in all_results)
    total_warnings = sum(len(r['warnings']) for r in all_results)
    total_errors = sum(len(r['errors']) for r in all_results)
    
    print("\n" + "="*50)
    print("PROPAGATION SUMMARY")
    print("="*50)
    
    if total_success > 0:
        print(f"✅ Successfully linked: {total_success} configs")
        
    if total_warnings > 0:
        print(f"⚠️  Warnings: {total_warnings}")
        for results in all_results:
            for warning in results['warnings']:
                print(f"   • {warning}")
                
    if total_errors > 0:
        print(f"❌ Errors: {total_errors}")
        for results in all_results:
            for error in results['errors']:
                print(f"   • {error}")
    
    if total_errors == 0:
        print("🎉 All configurations propagated successfully!")
    
    print("="*50)


def main():
    parser = argparse.ArgumentParser(
        description="Propagate dotfiles from repo to destinations"
    )
    parser.add_argument(
        "configs", nargs="*", help="Specific configs to propagate (leave empty for all)"
    )
    parser.add_argument(
        "--core", action="store_true", help="Propagate only core configs"
    )
    args = parser.parse_args()

    if args.core:
        # Propagate only core configs
        configs_to_propagate = core_configs
    elif args.configs:
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

    all_results = []
    
    for config in configs_to_propagate:
        target_dir = destinations.get(config)
        if target_dir:
            results = create_link(repo, target_dir, [config], safe_mode=False)
            all_results.append(results)
        else:
            # Handle missing destination
            all_results.append({
                'success': [],
                'warnings': [],
                'errors': [f"{config}: not found in destination.yaml"]
            })
    
    print_summary(all_results)


if __name__ == "__main__":
    main()
