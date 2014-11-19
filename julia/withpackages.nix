{ stdenv, ... } :

stdenv.mkDerivation rec {
  pname = "julia-withpackages";
  version = "0.0.0";
  name = "${pname}-${version}";

  src = ./jwp-src;
  
  installPhase = ''
    mkdir -p $out/{bin,share}
    substituteInPlace jwp --replace INSTALLSCRIPT $out/share/installpackages.jl
	cp jwp $out/bin
	cp installpackages.jl $out/share
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
