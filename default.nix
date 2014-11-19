with import <nixpkgs> {}; rec {
  lmdb = callPackage ./lmdb {};  
  cudatoolkit6_5 = callPackage ./cudatoolkit/6.5.nix {};
  caffe = callPackage ./caffe { lmdb = lmdb; cudatoolkit6_5 = cudatoolkit6_5; };
  caffecpu = callPackage ./caffe { lmdb = lmdb; cudatoolkit6_5 = cudatoolkit6_5; cpuonly = true; };
  halide = callPackage ./halide {};
  julia040 = callPackage ./julia/0.4.0pre.nix {};
  caffejl = callPackage ./caffejl {};
  #caffejl = callPackage ./caffejl { caffe = caffecpu; };
  juliawithpackages = callPackage ./julia/withpackages.nix {};
}
