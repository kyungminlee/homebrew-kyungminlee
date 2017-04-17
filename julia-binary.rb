class JuliaBinary < Formula
  desc "The Julia programming language"
  homepage "https://julialang.org"
  version "0.5.1"

  depends_on "patchelf"

  if MacOS.prefer_64_bit?
    url "https://julialang.s3.amazonaws.com/bin/linux/x64/0.5/julia-#{version}-linux-x86_64.tar.gz"
    sha256 "ae9512a9e0838e7e579acc3af653c220ff51206ec921967da8c72e8402105ed3"
  else
    url "https://julialang.s3.amazonaws.com/bin/linux/x86/0.5/julia-#{version}-linux-i686.tar.gz"
    sha256 "da7d47782921c7908028572f1cb7281b79ff0a5b4d9cae9e7117c0ea53db776f"
  end

  devel do
    version "0.6.0-887815c69d"
    if MacOS.prefer_64_bit?
      url "https://s3.amazonaws.com/julianightlies/bin/linux/x64/0.6/julia-#{version}-linux64.tar.gz"
      sha256 "aefc56751b1553bcac1e54fa47e2b166346dc04baad2082a5e599aa8b1b56f57"
    else
      url "https://s3.amazonaws.com/julianightlies/bin/linux/x86/0.6/julia-#{version}-linux32.tar.gz"
      sha256 "51bfe84f09b066f761c05f6aef966a1f5671a270b5b14e6a83b0a2fd211df8bf"
    end
  end

  bottle :unneeded

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/bin/*"]
    system "#{Formula["patchelf"].opt_bin}/patchelf", "--set-rpath", "$ORIGIN/../lib:#{HOMEBREW_PREFIX}/lib", "#{bin}/julia"
    system "#{Formula["patchelf"].opt_bin}/patchelf", "--set-rpath", "$ORIGIN/../lib:#{HOMEBREW_PREFIX}/lib", "#{bin}/julia-debug"
  end
end
