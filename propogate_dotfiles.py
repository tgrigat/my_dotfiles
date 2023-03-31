import os
from typing import List, Any
from os.path import join, isdir, isfile, islink
import shutil

wkdir = os.getcwd()
user = os.environ.get("USER")

repo = wkdir
# home = join("/home/yang/script", "P_home")  # /home/yang, for tmux and .zshrc
home = os.environ.get("HOME")
dot_config = f"{home}/.config"

to_ignore = [".git", "dotflie.py", "confsync"]

to_home = [".zshrc", ".tmux.conf"]

# TODO list
# add .local/share

# read from the config directory
all_configs = [config for config in os.listdir(repo) if config not in to_ignore]


def remove(path):
    """param <path> could either be relative or absolute."""
    if os.path.isfile(path) or os.path.islink(path):
        os.remove(path)  # remove the file
    elif os.path.isdir(path):
        shutil.rmtree(path)  # remove dir and all contains
    else:
        raise ValueError("file {} is not a file or dir.".format(path))


def create_link(
    config_dir: str, target_dir: str, configs: List[str], safe_mode: Any = True
) -> None:

    for cfg in configs:

        if isdir(join(target_dir, cfg)) or isfile(join(target_dir, cfg)):
            if islink(join(target_dir, cfg)):
                # print(f"already symlink config: {cfg}")
                continue
            else:
                # TODO: file should be deleted or copied to the config_dir
                if safe_mode:
                    raise NotImplementedError(
                        f"{cfg} already exists at {target_dir}, please remove it manually"
                    )
                else:
                    remove(join(target_dir, cfg))
                    print(f"Warning: removed {cfg} in {target_dir}")

        # expect the cfg doesn't exists on the target_dir
        os.symlink(join(config_dir, cfg), join(target_dir, cfg))
        print(f"Link {cfg} to target")


# Scan for links that are not in repo, likely to be the one discarded. print a warning
def scan_for_unknown(config_dir: str, configs: List) -> None:
    for item in os.listdir(config_dir):
        if islink(join(config_dir, item)) and item not in configs:
            print(
                f"Warning: {item} in ~/.config is a symlink but not in config file. Please check if this is a discarded config."
            )


for config in all_configs:

    if config in to_home:
        create_link(repo, home, [config], safe_mode=True)
    else:
        create_link(repo, dot_config, [config], safe_mode=False)

# scan_for_unknown(home, all_configs)
scan_for_unknown(dot_config, all_configs)

print(f"finished the linking process")

# check if the directory already exists on the target

# create a symlink to the target

# Advanced:
# 1. check if target is already a symlink. If is, then pass (Logic for adding a new config to the folder)
# 2. add a list of files (.zshrc, .tmux) to the different target location
# 3. if a config is deleted in the repo, remove the symlink as well. TODO
