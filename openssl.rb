# This formula tracks 1.0.2 branch of OpenSSL, not the 1.1.0 branch. Due to
# significant breaking API changes in 1.1.0 other formulae will be migrated
# across slowly, so core will ship `openssl` & `openssl@1.1` for foreseeable.
class Openssl < Formula
  desc "SSL/TLS cryptography library"
  homepage "https://openssl.org/"
  url "https://www.openssl.org/source/openssl-1.0.2j.tar.gz"
  mirror "https://dl.bintray.com/homebrew/mirror/openssl-1.0.2j.tar.gz"
  mirror "https://www.mirrorservice.org/sites/ftp.openssl.org/source/openssl-1.0.2j.tar.gz"
  sha256 "e7aff292be21c259c6af26469c7a9b3ba26e9abaaffd325e3dccc9785256c431"

  bottle do
    sha256 "109fe24d2ee82d89e1ee60587d91c953cdd3384db5374e8e83635c456fa15ed0" => :sierra
    sha256 "7b331c548a5a82f7a111c6218be3e255a2a1a6c19888c2b7ceaf02f2021c1628" => :el_capitan
    sha256 "a3083052e81d711dd6da2d5bda7418d321eba26570a63818e52f5f68247c63f2" => :yosemite
    sha256 "292c3d5628a58908fdbc2e1587e27b1301890de043069fc08919d20f14871c07" => :x86_64_linux
  end

  resource "cacert" do
    # Update post_install when you update this resource.
    # homepage "http://curl.haxx.se/docs/caextract.html"
    url "https://curl.haxx.se/ca/cacert-2016-04-20.pem"
    sha256 "2c6d4960579b0d4fd46c6cbf135545116e76f2dbb7490e24cf330f2565770362"
  end

  keg_only :provided_by_osx,
    "Apple has deprecated use of OpenSSL in favor of its own TLS and crypto libraries"

  option :universal
  option "without-test", "Skip build-time tests (not recommended)"

  deprecated_option "without-check" => "without-test"

  depends_on "zlib" unless OS.mac?
  depends_on :perl => ["5.0", :build] unless OS.mac?

  patch :DATA

  def arch_args
    return { :i386 => %w[linux-generic32], :x86_64 => %w[linux-x86_64] } if OS.linux?
    {
      :x86_64 => %w[darwin64-x86_64-cc enable-ec_nistp_64_gcc_128],
      :i386 => %w[darwin-i386-cc],
    }
  end

  def configure_args; %W[
    --prefix=#{prefix}
    --openssldir=#{openssldir}
    no-ssl2
    zlib-dynamic
    shared
    enable-cms
    #{[ENV.cppflags, ENV.cflags, ENV.ldflags].join(" ").strip unless OS.mac?}
  ]
  end

  def install
    # OpenSSL will prefer the PERL environment variable if set over $PATH
    # which can cause some odd edge cases & isn't intended. Unset for safety.
    ENV.delete("PERL")

    # Load zlib from an explicit path instead of relying on dyld's fallback
    # path, which is empty in a SIP context. This patch will be unnecessary
    # when we begin building openssl with no-comp to disable TLS compression.
    # https://langui.sh/2015/11/27/sip-and-dlopen
    inreplace "crypto/comp/c_zlib.c",
              'zlib_dso = DSO_load(NULL, "z", NULL, 0);',
              'zlib_dso = DSO_load(NULL, "/usr/lib/libz.dylib", NULL, DSO_FLAG_NO_NAME_TRANSLATION);' if OS.mac?

    ENV.append_to_cflags "-Wa,--noexecstack" if OS.linux?

    if build.universal?
      ENV.permit_arch_flags
      archs = Hardware::CPU.universal_archs
    elsif MacOS.prefer_64_bit?
      archs = [Hardware::CPU.arch_64_bit]
    else
      archs = [Hardware::CPU.arch_32_bit]
    end

    dirs = []

    archs.each do |arch|
      if build.universal?
        dir = "build-#{arch}"
        dirs << dir
        mkdir dir
        mkdir "#{dir}/engines"
        system "make", "clean"
      end

      ENV.deparallelize
      system "perl", "./Configure", *(configure_args + arch_args[arch])
      system "make", "depend"
      system "make"
      if which "cmp"
        system "make", "test" if build.with?("test")
      else
        opoo "Skipping `make check` due to unavailable `cmp`"
      end

      next unless build.universal?
      cp "include/openssl/opensslconf.h", dir
      cp Dir["*.?.?.?.dylib", "*.a", "apps/openssl"], dir
      cp Dir["engines/**/*.dylib"], "#{dir}/engines"
    end

    system "make", "install", "MANDIR=#{man}", "MANSUFFIX=ssl"

    if build.universal?
      %w[libcrypto libssl].each do |libname|
        system "lipo", "-create", "#{dirs.first}/#{libname}.1.0.0.dylib",
                                  "#{dirs.last}/#{libname}.1.0.0.dylib",
                       "-output", "#{lib}/#{libname}.1.0.0.dylib"
        system "lipo", "-create", "#{dirs.first}/#{libname}.a",
                                  "#{dirs.last}/#{libname}.a",
                       "-output", "#{lib}/#{libname}.a"
      end

      Dir.glob("#{dirs.first}/engines/*.dylib") do |engine|
        libname = File.basename(engine)
        system "lipo", "-create", "#{dirs.first}/engines/#{libname}",
                                  "#{dirs.last}/engines/#{libname}",
                       "-output", "#{lib}/engines/#{libname}"
      end

      system "lipo", "-create", "#{dirs.first}/openssl",
                                "#{dirs.last}/openssl",
                     "-output", "#{bin}/openssl"

      confs = archs.map do |arch|
        <<-EOS.undent
          #ifdef __#{arch}__
          #{(buildpath/"build-#{arch}/opensslconf.h").read}
          #endif
          EOS
      end
      (include/"openssl/opensslconf.h").atomic_write confs.join("\n")
    end
  end

  def openssldir
    etc/"openssl"
  end

  def post_install
    unless OS.mac?
      # Download and install cacert.pem from curl.haxx.se
      (etc/"openssl").install resource("cacert").files("cacert-2016-04-20.pem" => "cert.pem")
      return
    end

    keychains = %w[
      /System/Library/Keychains/SystemRootCertificates.keychain
    ]

    certs_list = `security find-certificate -a -p #{keychains.join(" ")}`
    certs = certs_list.scan(
      /-----BEGIN CERTIFICATE-----.*?-----END CERTIFICATE-----/m
    )

    valid_certs = certs.select do |cert|
      IO.popen("#{bin}/openssl x509 -inform pem -checkend 0 -noout", "w") do |openssl_io|
        openssl_io.write(cert)
        openssl_io.close_write
      end

      $?.success?
    end

    openssldir.mkpath
    (openssldir/"cert.pem").atomic_write(valid_certs.join("\n"))
  end

  def caveats; <<-EOS.undent
    A CA file has been bootstrapped using certificates from the SystemRoots
    keychain. To add additional certificates (e.g. the certificates added in
    the System keychain), place .pem files in
      #{openssldir}/certs

    and run
      #{opt_bin}/c_rehash
    EOS
  end

  test do
    # Make sure the necessary .cnf file exists, otherwise OpenSSL gets moody.
    assert (HOMEBREW_PREFIX/"etc/openssl/openssl.cnf").exist?,
            "OpenSSL requires the .cnf file for some functionality"

    # Check OpenSSL itself functions as expected.
    (testpath/"testfile.txt").write("This is a test file")
    expected_checksum = "e2d0fe1585a63ec6009c8016ff8dda8b17719a637405a4e23c0ff81339148249"
    system "#{bin}/openssl", "dgst", "-sha256", "-out", "checksum.txt", "testfile.txt"
    open("checksum.txt") do |f|
      checksum = f.read(100).split("=").last.strip
      assert_equal checksum, expected_checksum
    end
  end
end
__END__
--- a/Configure	2017-01-06 10:46:19.801766500 -0500
+++ b/Configure	2017-01-06 10:48:16.149240600 -0500
@@ -1721,15 +1721,15 @@
 		s/^NM=\s*/NM= \$\(CROSS_COMPILE\)/;
 		s/^RANLIB=\s*/RANLIB= \$\(CROSS_COMPILE\)/;
 		s/^RC=\s*/RC= \$\(CROSS_COMPILE\)/;
-		s/^MAKEDEPPROG=.*$/MAKEDEPPROG= \$\(CROSS_COMPILE\)$cc/ if $cc eq "gcc";
+		s/^MAKEDEPPROG=.*$/MAKEDEPPROG= \$\(CROSS_COMPILE\)$cc/ if $cc =~ /gcc.*/;
 		}
 	else	{
 		s/^CC=.*$/CC= $cc/;
 		s/^AR=\s*ar/AR= $ar/;
 		s/^RANLIB=.*/RANLIB= $ranlib/;
 		s/^RC=.*/RC= $windres/;
-		s/^MAKEDEPPROG=.*$/MAKEDEPPROG= $cc/ if $cc eq "gcc";
-		s/^MAKEDEPPROG=.*$/MAKEDEPPROG= $cc/ if $ecc eq "gcc" || $ecc eq "clang";
+		s/^MAKEDEPPROG=.*$/MAKEDEPPROG= $cc/ if $cc =~ /gcc.*/;
+		s/^MAKEDEPPROG=.*$/MAKEDEPPROG= $cc/ if $ecc =~ /gcc.*/ || $ecc =~ /clang.*/;
 		}
 	s/^CFLAG=.*$/CFLAG= $cflags/;
 	s/^DEPFLAG=.*$/DEPFLAG=$depflags/;
