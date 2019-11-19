with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "nix-shell-elixir-inspector";
  env = buildEnv {
    name = name;
    paths = buildInputs;
  };

  shellHook = ''
    export SHELL_DATA_DIR="$(pwd)/runtime"

    export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$SHELL_DATA_DIR/erlang-history\"'"
    export HEX_HOME="$SHELL_DATA_DIR/hex"
    export MIX_HOME="$SHELL_DATA_DIR/mix"
    export PS1="[elixir-inspector|\[\e[1m\]\w\[\e[0m\]]$ "
  '';

  elixir = pkgs.callPackage ./packages/elixir {};

  buildInputs = [
    elixir
    erlang
    nodejs

    inotify-tools
  ];
}
