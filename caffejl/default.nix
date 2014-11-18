{ cpuonly ? false, stdenv, fetchgit, fetchurl,  julia,  ... }:

let
  rev = "c328d2ca9d";
in
stdenv.mkDerivation { 
  name = "caffejl"; 
  #buildInputs = [ caffe ];
  src = fetchgit {
    url = file:///home/rene/g/caffejl;
    inherit rev;
    md5 = "ecb730806ad0b65e93f99b2d2d90c442";
  };

  configurePhase = ''
    mkdir build
    cd build
    cmake ${if cpuonly then "-DCPU_ONLY=ON" else ""} -DCMAKE_BUILD_TYPE=Release -DCMAKE_SKIP_BUILD_RPATH=ON -DCMAKE_INSTALL_PREFIX=$out -DBLAS=open ..
  '';

  buildPhase = ''
	make all -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    make install
	mkdir $out/shared
	cp -r examples $out/shared
	cp -r data $out/shared
    ln -s $out/tools $out/bin
  '';

}
