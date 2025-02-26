# lefthook git hooks

install pip
python -m ensurepip --upgrade

install lefthook
python -m pip install --user lefthook

cd your/project
lefthook install

-----


process:
vim lefthook.yml - add as a submodule??
lefthook install - install the hooks



-----

in other projects add this config

remote:
  git: https://github.com/organization/lefthook-configs
  config: lefthook-golang.yml

run 
lefthook install
locally if changes are made to the above repo
