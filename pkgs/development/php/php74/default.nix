{ lib, stdenv, fetchurl, autoconf, bison, libtool, pkgconfig, re2c
, libmysqlclient, libxml2, readline, zlib, curl, postgresql, gettext, openssl
, pcre, pcre2, sqlite, config, libjpeg, libpng, freetype, libxslt, libmcrypt
, bzip2, icu, openldap, cyrus_sasl, libmhash, unixODBC, uwimap, pam, gmp
, apacheHttpd, libiconv, systemd, libsodium, html-tidy, libargon2, libzip
, valgrind, oniguruma, mysql57, libwebp }:

stdenv.mkDerivation rec {
  name = "php7.4";
  version = "7.4.0RC5";
  enableParallelBuilding = true;
  nativeBuildInputs = [ autoconf bison libtool pkgconfig re2c ];
  buildInputs = [
    pcre2
    systemd
    curl
    openssl
    libpng
    libjpeg
    libwebp
    freetype
    openssl
    openssl.dev
    libmhash
    zlib
    libxml2
    readline
    sqlite
    mysql57
    gmp
    gettext
    icu
    libxslt
    bzip2
    libsodium
    libzip
    libargon2
    valgrind
    oniguruma
  ];

  configureFlags = [
    "--with-config-file-scan-dir=/etc/php.d"
    "--with-pcre-regex=${pcre2.dev} PCRE_LIBDIR=${pcre2}"
    "--with-curl"
    "--with-zlib"
    "--with-libxml"
    "--with-readline"
    "--with-pdo-sqlite"
    "--with-pdo-mysql=${mysql57}"
    "--with-mysqli=${mysql57}/bin/mysql_config"
    "--with-mysql-sock=/run/mysqld/mysqld.sock"
    "--enable-gd"
    "--with-freetype"
    "--with-png"
    "--with-jpeg"
    "--with-webp"
    "--enable-soap"
    "--enable-sockets"
    "--with-openssl"
    "--enable-intl"
    "--enable-exif"
    "--with-bz2=${bzip2.dev}"
    "--with-readline=${readline.dev}"
    "--with-pdo-sqlite=${sqlite.dev}"
    "--enable-zip"
    "--enable-ftp"
    "--enable-calendar"
    "--enable-fpm"
    "--with-sodium"
    "--enable-bcmath"
    "--with-valgrind=${valgrind.dev}"
  ];

  preConfigure = ''
           # Don't record the configure flags since this causes unnecessary
           # runtime dependencies
           for i in main/build-defs.h.in scripts/php-config.in; do
             substituteInPlace $i \
               --replace '@CONFIGURE_COMMAND@' '(omitted)' \
               --replace '@CONFIGURE_OPTIONS@' "" \
               --replace '@PHP_LDFLAGS@' ""
           done
           #[[ -z "$libxml2" ]] || addToSearchPath PATH $libxml2/bin
           export EXTENSION_DIR=$out/lib/php/extensions
           configureFlags+=(--with-config-file-path=$out/etc \
             --includedir=$dev/include)
    cp main/php_version.h main/php_version_copy.h 
     ./buildconf --force
         '';

  preBuild = "cp main/php_version_copy.h main/php_version.h";

  postInstall = ''
    test -d $out/etc || mkdir $out/etc
    cp php.ini-production $out/etc/php.ini
  '';

  postFixup = ''
    mkdir -p $dev/bin $dev/share/man/man1
    mv $out/bin/phpize $out/bin/php-config $dev/bin/
    mv $out/share/man/man1/phpize.1.gz \
      $out/share/man/man1/php-config.1.gz \
      $dev/share/man/man1/
  '';

  src = fetchurl rec {
    url = "https://downloads.php.net/~derick/php-7.4.0RC5.tar.bz2";
    sha256 = "1p9p801ychz46dznx57jr07gyqq2v3lx0990h3n9pak8hba2gw0h";
  };
}

