require 'formula'

class Freetds < Formula
  homepage 'http://www.freetds.org/'
  url 'http://mirrors.ibiblio.org/freetds/stable/freetds-0.91.tar.gz'
  sha1 '3ab06c8e208e82197dc25d09ae353d9f3be7db52'

  option 'with-unixodbc', "Compile against unixODBC"

  depends_on "pkg-config" => :build
  depends_on "unixodbc" if build.include? "with-unixodbc"

  def install
    args = %W[--prefix=#{prefix}
              --with-openssl=/usr/bin
              --with-tdsver=7.1
              --mandir=#{man}
            ]

    if build.include? "with-unixodbc"
      args << "--with-unixodbc=#{Formula.factory('unixodbc').prefix}"
    end

    system "./configure", *args
    system 'make'
    ENV.j1 # Or fails to install on multi-core machines
    system 'make install'
  end
end
