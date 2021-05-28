{ lib
, stdenv
, fetchFromGitHub
, cmake
, llvmPackages
, libxml2
, zlib
}:

llvmPackages.stdenv.mkDerivation rec {
  pname = "zig";
  version = "673ae5b457479760ff8e08b3e06917a4b2651436";

  src = fetchFromGitHub {
    owner = "ziglang";
    repo = pname;
    rev = version;
    hash = "sha256-GmNDvBO9IGHcz5BaJ+0AL+63/7ZA3hpWdSJEXS/nTzQ=";
  };

  nativeBuildInputs = [
    cmake llvmPackages.llvm.dev
  ];
  buildInputs = [
    libxml2
    zlib
  ] ++ (with llvmPackages; [
    libclang
    lld
    llvm
  ]);

  preBuild = ''
    export HOME=$TMPDIR;
  '';

  checkPhase = ''
    runHook preCheck
    #./zig test --cache-dir "$TMPDIR" -I $src/test $src/test/stage1/behavior.zig
    runHook postCheck
  '';

  doCheck = true;

  meta = with lib; {
    homepage = "https://ziglang.org/";
    description =
      "General-purpose programming language and toolchain for maintaining robust, optimal, and reusable software";
    license = licenses.mit;
    maintainers = with maintainers; [ andrewrk AndersonTorres ];
    platforms = platforms.unix;
    # See https://github.com/NixOS/nixpkgs/issues/86299
    broken = stdenv.isDarwin;
  };
}
