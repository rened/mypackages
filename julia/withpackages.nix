{ stdenv, fetchgit, ... } :

let
	rev = "dcc0b96d2adcb6bcf6a139f526718d7a335e0d11";
in
stdenv.mkDerivation rec {
  pname = "juliawithpackages";
  #version = "0.0.0";
  name = "${pname}";

  src = fetchgit {
	  url = http://github.com/rened/juliawithpackages.git;
      inherit rev;
	  md5 = "047410ea6099f4a4556db38088687c63";
  };
  
  installPhase = ''
    mkdir -p $out/bin
	cp jwp $out/bin
	cp installpackages.jl $out/bin
    chmod +x $out/bin/jwp
  '';

  meta = {
    #description = "High-level performance-oriented dynamical language for technical computing";
    #homepage = "http://julialang.org/";
    license = stdenv.lib.licenses.mit;
    #maintainers = [ stdenv.lib.maintainers.raskin ];
    platforms = with stdenv.lib.platforms; linux;
    broken = false;
  };
}
