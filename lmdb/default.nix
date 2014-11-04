{ stdenv, fetchgit, ... }:

stdenv.mkDerivation rec { 
  version = "0.9.14";
  name = "lmdb-${version}"; 
  src = fetchgit {
	  url = https://gitorious.org/mdb/mdb.git;
      rev = "2f587ae081d076";
	  md5 = "c4d387877b9fc57b9a910e6f74cd10c7";
  };

  patchPhase = ''
    cd libraries/liblmdb
    sed -e "s#prefix.*/usr/local.*#prefix = $out#" -i Makefile
  '';

  installPhase = ''
    mkdir -p $out/man/man1
	mkdir $out/bin
	mkdir $out/include
	mkdir $out/lib
    make install
  '';

}

