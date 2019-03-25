{ mkDerivation, base, servant, servant-server, stdenv, text, warp
}:
mkDerivation {
  pname = "ultrabook";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base ];
  executableHaskellDepends = [
    base servant servant-server text warp
  ];
  homepage = "https://github.com/rubenmoor/ultrabook";
  license = stdenv.lib.licenses.unlicense;
}
