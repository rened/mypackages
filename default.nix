with import /home/rene/nixpkgs/default.nix {}; rec {
  lmdb = callPackage ./lmdb {};  
  cudatoolkit6_5 = callPackage ./cudatoolkit/6.5.nix {};
  caffe = callPackage ./caffe { lmdb = lmdb; cudatoolkit6_5 = cudatoolkit6_5; };
  caffe-cpu = callPackage ./caffe { lmdb = lmdb; cudatoolkit6_5 = cudatoolkit6_5; cpuonly = true; };
  halide = callPackage ./halide {};
}
