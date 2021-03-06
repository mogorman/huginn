with (import <nixpkgs> {});
let
  env = bundlerEnv {
    name = "huginn";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in stdenv.mkDerivation {
  name = "huginn";
  buildInputs = [env ruby v8 curl postgresql ];
  shellHook = ''
    export PS1="huginn> "
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
    export LD_LIBRARY_PATH=${curl.out}/lib:${postgresql}/lib
'';
}
