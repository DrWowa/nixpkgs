{ fetchurl, stdenv, ncurses }:

stdenv.mkDerivation rec {
  name = "nmon-${version}";
  version = "16k";

  src = fetchurl {
    url = "mirror://sourceforge/nmon/lmon${version}.c";
    sha256 = "17nbxrnl7kqiaaxn2hwyi65gphbl3wybbyp9vri2q5ifdis3ssib";
  };

  buildInputs = [ ncurses ];
  unpackPhase = ":";
  buildPhase = "cc -o nmon ${src} -g -O2 -D JFS -D GETUSER -Wall -D LARGEMEM -lncurses -lm -g -D X86";
  installPhase = ''
    mkdir -p $out/bin
    cp nmon $out/bin
  '';

  meta = with stdenv.lib; {
    description = "AIX & Linux Performance Monitoring tool";
    homepage = "http://nmon.sourceforge.net";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ sveitser ];
  };
}
