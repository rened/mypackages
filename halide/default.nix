{ stdenv, fetchgit, clang_33, llvm_33, ... }:

let
  rev = "1de2c35db0";
in
stdenv.mkDerivation rec { 
  name = "lmdb-${rev}"; 
  src = fetchgit {
	  url = https://github.com/halide/Halide.git;
      inherit rev;
	  md5 = "10626a7cabfea4328329faf43d93de4c";
  };
  buildInputs = [ clang_33 llvm_33 ];

}

