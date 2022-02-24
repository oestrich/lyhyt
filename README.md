# Lyhyt

A URL shortener written with [Aino](https://ainoweb.dev). Lyhyt means "short" in Finnish.

## Setup

Install [the nix package manager](https://nixos.org/download.html#nix-install-macos) by following their multi-user installer. Once nix is installed, setup [direnv](https://direnv.net/) by hooking into your shell.

```bash
nix-env -f '<nixpkgs>' -iA direnv
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
```

Once direnv is installed and your shell is restarted, clone the project and `cd` into it. You should see direnv warn about an untrusted `.envrc` file. Allow the file and finish installing dependencies and setting up the application.

```bash
direnv allow

mix deps.get
mix ecto.create
mix ecto.migrate
(cd assets && yarn install && yarn build:css)
mix run --no-halt
```
