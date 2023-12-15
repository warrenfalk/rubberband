{
  description = "A flake for building Hello World";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux =
      # Notice the reference to nixpkgs here.
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation {
        name = "rubberband";
        src = self;
        nativeBuildInputs = [ pkg-config ];
        buildInputs = [
          libsamplerate
          libsndfile
          fftw
          vamp-plugin-sdk
          ladspaH
          lv2
          jdk
        ];
        buildPhase = ''
          make
          make jni JAVA_HOME=${jdk}
        '';
        shellHook = ''
          export PS1="(devenv) $PS1"
        '';        
      };

  };
}