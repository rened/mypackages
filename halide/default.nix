{ stdenv, fetchgit, llvm_33, ... }:

let
  rev = "1de2c35db0";
in
stdenv.mkDerivation rec { 
  name = "lmdb-${rev}"; 
  src = fetchgit {
	  url = https://github.com/halide/Halide.git;
      inherit rev;
	  md5 = "c4d387877b9fc57b9a910e6f74cd10c7";
  };
  buildIndputs = [ llvm_33 ];

}

