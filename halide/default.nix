{ stdenv, fetchgit, fetchsvn, subversion, python, zlib, ... }:

let
  rev = "1de2c35db0";
in
stdenv.mkDerivation rec { 
  name = "halide-${rev}"; 
  src = fetchgit {
	  url = https://github.com/halide/Halide.git;
      inherit rev;
	  md5 = "10626a7cabfea4328329faf43d93de4c";
  };

  llvmsrc = fetchsvn {
	  url = https://llvm.org/svn/llvm-project/llvm/branches/release_33;
	  md5 = "669c54fccef0f09cdf2645ab885ff5c6";
  };

  clangsrc = fetchsvn {
	  url = https://llvm.org/svn/llvm-project/cfe/branches/release_33;
	  md5 = "0b2629a04e2a16c4ef55ec28159ea279";
  };

#  patchPhase = ''
#    sed -e "s#CLANG)#DUMMY_IGNORE)#" -i CMakeLists.txt
#  '';

  buildInputs = [ subversion python zlib ];
  configurePhase = ''
    svn co --trust-server-cert https://llvm.org/svn/llvm-project/llvm/branches/release_33 llvm3.3
	svn co --trust-server-cert https://llvm.org/svn/llvm-project/cfe/branches/release_33 llvm3.3/tools/clang
	cd llvm3.3
	./configure --disable-terminfo --enable-optimized --enable-assertions --with-clang --enable-targets=x86,arm,nvptx
	make -j8
	cd ..
    export LLVM_CONFIG=llvm3.3/Release+Asserts/bin/llvm-config
    export CLANG=llvm3.3/Release+Asserts/bin/clang
    make && make run_tests && make test_apps
  '';

}

