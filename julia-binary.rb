class JuliaBinary < Formula
  desc "The Julia programming language"
  homepage "https://julialang.org"
  version "0.5.0"

  if MacOS.prefer_64_bit?
    url "https://julialang.s3.amazonaws.com/bin/linux/x64/0.5/julia-0.5.0-linux-x86_64.tar.gz"
    sha256 "5b18bbfcc39b2214ce5ec5d3c186aa39dbcab0bc465415353d44762fe14d1183"
  else
    url "https://julialang.s3.amazonaws.com/bin/linux/x86/0.5/julia-0.5.0-linux-i686.tar.gz"
    sha256 "77aa539e48b260076d6e0baedb783b90c7478a88755f0671d78c7d8954ec95bf"
  end

  devel do
    version "0.6.0-887815c69d"
    if MacOS.prefer_64_bit?
      url "https://s3.amazonaws.com/julianightlies/bin/linux/x64/0.6/julia-0.6.0-887815c69d-linux64.tar.gz"
      sha256 "aefc56751b1553bcac1e54fa47e2b166346dc04baad2082a5e599aa8b1b56f57"
    else
      url "https://s3.amazonaws.com/julianightlies/bin/linux/x86/0.6/julia-0.6.0-887815c69d-linux32.tar.gz"
      sha256 "51bfe84f09b066f761c05f6aef966a1f5671a270b5b14e6a83b0a2fd211df8bf"
    end
  end

  bottle :unneeded

  def install
    libexec.install Dir["*"]
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end
end
