with import ../nixpkgs/default.nix {}; rec {
  lmdb = callPackage ./lmdb {};  
  cudatoolkit6_5 = callPackage ./cudatoolkit/6.5.nix {};
  caffe = callPackage ./caffe { lmdb = lmdb; cudatoolkit6_5 = cudatoolkit6_5; };
  caffecpu = callPackage ./caffe { lmdb = lmdb; cudatoolkit6_5 = cudatoolkit6_5; cpuonly = true; };
  halide = callPackage ./halide {};
  julia = callPackage ./julia/0.3.2.nix {};
}
