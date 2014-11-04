{ cpuonly ? false, stdenv, fetchgit, fetchurl, gcc46, lmdb, cmake, unzip, openblas, cudatoolkit6_5, opencv, boost, glog, google-gflags, protobuf, protobufc, leveldb, snappy, hdf5, ... }:

let
  rev = "c18d22eb92";
in
stdenv.mkDerivation { 
  name = "caffe-${ if cpuonly then "cpu-" else ""}${rev}"; 
  buildInputs = (if cpuonly then [] else [ cudatoolkit6_5 ]) ++ [ gcc46 lmdb cmake unzip openblas opencv boost glog google-gflags protobuf protobufc leveldb snappy hdf5 ];
  src = fetchgit {
    url = https://github.com/BVLC/caffe.git;
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
    ln -s $out/tools $out/bin
  '';

}
