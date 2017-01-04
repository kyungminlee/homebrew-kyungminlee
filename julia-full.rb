class JuliaFull < Formula
  desc "The Julia programming language"
  homepage "https://julialang.org"
  url "https://github.com/JuliaLang/julia/releases/download/v0.5.0/julia-0.5.0-full.tar.gz"
  sha256 "732478536b6dccecbf56e541eef0aed04de0e6d63ae631b136e033dda2e418a9"
  version "0.5.0"
  head "https://github.com/JuliaLang/julia.git"

  depends_on :python
  depends_on :fortran
  depends_on :perl => "5.0"
  depends_on "curl" unless OS.mac?
  depends_on "homebrew/dupes/m4" => :build unless OS.mac?
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build

  option "system-libm", "Use system's libm instead of openlibm"
  #option "openblas-dynamic-arch", "Build OpenBLAS with dynamic arch support."
  #option "openblas-no-avx2", "Build OpenBLAS without AVX2 support."

  def install
    build_opts = ["prefix=#{prefix}"]
    build_opts << "-j" << "1"
    build_opts << "MARCH=core2" if build.bottle?
    build_opts << "VERBOSE=1" if ARGV.verbose?
    #build_opts << "OPENBLAS_DYNAMIC_ARCH=1" 
    #build_opts << "OPENBLAS_NO_AVX2=1"
    build_opts << "OPENBLAS_DYNAMIC_ARCH=0" 
    build_opts << "OPENBLAS_USE_THREAD=0"
    build_opts << "OPENBLAS_TARGET_ARCH=CORE2"
    build_opts << "MARCH=core2"
    build_opts << "USE_SYSTEM_LIBM=1" if build.include? "system-libm"

    begin
        build_opts << "julia-deps"
        system "make", *build_opts
        build_opts.pop
    rescue
        # do nothing
    end

    build_opts << "julia-deps"
    system "make", *build_opts
    build_opts.pop

    system "make", *build_opts

    build_opts << "install"
    system "make", *build_opts
  end

  #test do
  def test
    # Run julia-provided test suite, copied over in install step
    if not (share + 'julia/test').exist?
      err = "Could not find test files directory\n"
      if build.head?
        err << "Did you accidentally include --HEAD in the test invocation?"
      else
        err << "Did you mean to include --HEAD in the test invocation?"
      end
      opoo err
    else
      system "#{bin}/julia", "-e", "Base.runtests(\"core\")"
    end
  end
end
