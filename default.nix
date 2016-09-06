with (import <nixpkgs> {});
let
  env = bundlerEnv {
    name = "huginn";
    inherit ruby;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;

  extraCmds = ''
  export LANG='en_US.UTF-8'
  '';

  shellHook = ''
  export LANG='en_US.UTF-8'
  '';


    buildInputs = with self; [ pkgs.glibcLocales ];
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";

  };
in stdenv.mkDerivation {
  name = "huginn";
  buildInputs = [env ruby v8 curl postgresql glibcLocales ];
  shellHook = ''
    export SSL_CERT_FILE=${cacert}/etc/ssl/certs/ca-bundle.crt
    export GEM_HOME=./rubygems
    export PATH=./rubygems/bin:$PATH
    export LD_LIBRARY_PATH=${curl}/lib:${postgresql}/lib
    export LANG=en_US.UTF-8
'';
  # used when building environments
  extraCmds = ''
  export LANG='en_US.UTF-8'
  '';
  preConfigure = ''
    echo "I AM DOING SOMETHING"
    sleep 40
    export LANG="en_US.UTF-8"
    export LOCALE_ARCHIVE=$glibcLocales/lib/locale/locale-archive
'';
}
