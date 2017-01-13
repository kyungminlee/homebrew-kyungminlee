class Triqs < Formula
  desc "Toolbox for Research on Interacting Quantum Systems"
  homepage "https://triqs.ipht.cnrs.fr"
  head "https://github.com/TRIQS/triqs.git"

  stable do
    url "https://github.com/TRIQS/triqs/archive/1.3.2.tar.gz"
    sha256 "5a59f2fd6256cd09ece12718bd56ed8218ea091c3001ff14f08693206bca74b3"

    patch do
      url "https://github.com/TRIQS/triqs/commit/acab58a59375028f5fee907dbc3d80de1ef496ae.patch"
      sha256 "88b1bbb9abdfa930c722773a22c573136dae0e94555708cec21d0668c7fd0f45"
    end

    patch do
      url "https://github.com/TRIQS/triqs/commit/44db9d0e131c36eb8f7fc8bc9323fbd1a2117571.patch"
      sha256 "457ea8c39e50b65bc90edb0ab46732b720a999e64506056164b9fdb77295481e"
    end
  end

  bottle :unneeded # temporary
  needs :cxx11

  option "with-doc", "Build documentation"
  option "with-test", "Verify the build with `make test`"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build

  depends_on :fortran
  depends_on :python
  depends_on :mpi => [:cc, :cxx]

  depends_on "boost" => "with-mpi"
  depends_on "boost-python"
  depends_on "fftw"
  depends_on "gmp"
  depends_on "zeromq"
  depends_on "doxygen" if build.with? "doc"

  depends_on "homebrew/science/hdf5" => "without-mpi"
  depends_on "homebrew/science/openblas" => (OS.mac? ? :optional : :recommended)

  numpy_options = []
  numpy_options << "with-openblas" if build.with? "openblas"
  depends_on "homebrew/python/numpy" => numpy_options
  depends_on "homebrew/python/scipy" => numpy_options

  depends_on "homebrew/python/h5py" => "without-mpi"
  depends_on "homebrew/python/matplotlib"
  depends_on "homebrew/python/mpi4py"

  resource "backports_abc" do
    url "https://files.pythonhosted.org/packages/68/3c/1317a9113c377d1e33711ca8de1e80afbaf4a3c950dd0edfaf61f9bfe6d8/backports_abc-0.5.tar.gz"
    sha256 "033be54514a03e255df75c5aee8f9e672f663f93abb723444caec8fe43437bde"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/4f/75/e1bc6e363a2c76f8d7e754c27c437dbe4086414e1d6d2f6b2a3e7846f22b/certifi-2016.9.26.tar.gz"
    sha256 "8275aef1bbeaf05c53715bfc5d8569bd1e04ca1e8e69608cc52bcaac2604eb19"
  end

  resource "Mako" do
    url "https://files.pythonhosted.org/packages/56/4b/cb75836863a6382199aefb3d3809937e21fa4cb0db15a4f4ba0ecc2e7e8e/Mako-1.0.6.tar.gz"
    sha256 "48559ebd872a8e77f92005884b3d88ffae552812cdf17db6768e5c3be5ebbe0d"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz"
    sha256 "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3"
  end

  resource "pyzmq" do
    url "https://files.pythonhosted.org/packages/af/37/8e0bf3800823bc247c36715a52e924e8f8fd5d1432f04b44b8cd7a5d7e55/pyzmq-16.0.2.tar.gz"
    sha256 "0322543fff5ab6f87d11a8a099c4c07dd8a1719040084b6ce9162bcdf5c45c9d"
  end

  resource "singledispatch" do
    url "https://files.pythonhosted.org/packages/d9/e9/513ad8dc17210db12cb14f2d4d190d618fb87dd38814203ea71c87ba5b68/singledispatch-3.4.0.3.tar.gz"
    sha256 "5b06af87df13818d14f08a028e42f566640aef80805c3b50c5056b086e3c2b9c"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz"
    sha256 "105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a"
  end

  resource "tornado" do
    url "https://files.pythonhosted.org/packages/1e/7c/ea047f7bbd1ff22a7f69fe55e7561040e3e54d6f31da6267ef9748321f98/tornado-4.4.2.tar.gz"
    sha256 "2898f992f898cd41eeb8d53b6df75495f2f423b6672890aadaf196ea1448edcc"
  end

  if build.with? "doc"
    resource "alabaster" do
      url "https://files.pythonhosted.org/packages/71/c3/70da7d8ac18a4f4c502887bd2549e05745fa403e2cd9d06a8a9910a762bc/alabaster-0.7.9.tar.gz"
      sha256 "47afd43b08a4ecaa45e3496e139a193ce364571e7e10c6a87ca1a4c57eb7ea08"
    end

    resource "Babel" do
      url "https://files.pythonhosted.org/packages/6e/96/ba2a2462ed25ca0e651fb7b66e7080f5315f91425a07ea5b34d7c870c114/Babel-2.3.4.tar.gz"
      sha256 "c535c4403802f6eb38173cd4863e419e2274921a01a8aad8a5b497c131c62875"
    end

    resource "clang" do
      url "https://files.pythonhosted.org/packages/5a/aa/22c42abe5bc0d6396f0fc7c24b4be793011c7bd6456ba78a4aca23e9cdb7/clang-3.8.tar.gz"
      sha256 "8a3f1203c4148348e62ee602f11a5eb0fbb5c462e361b16aee6b4c2836088d5a"
    end

    resource "docutils" do
      url "https://files.pythonhosted.org/packages/05/25/7b5484aca5d46915493f1fd4ecb63c38c333bd32aa9ad6e19da8d08895ae/docutils-0.13.1.tar.gz"
      sha256 "718c0f5fb677be0f34b781e04241c4067cbd9327b66bdd8e763201130f5175be"
    end

    resource "imagesize" do
      url "https://files.pythonhosted.org/packages/53/72/6c6f1e787d9cab2cc733cf042f125abec07209a58308831c9f292504e826/imagesize-0.7.1.tar.gz"
      sha256 "0ab2c62b87987e3252f89d30b7cedbec12a01af9274af9ffa48108f2c13c6062"
    end

    resource "pyparsing" do
      url "https://files.pythonhosted.org/packages/38/bb/bf325351dd8ab6eb3c3b7c07c3978f38b2103e2ab48d59726916907cd6fb/pyparsing-2.1.10.tar.gz"
      sha256 "811c3e7b0031021137fc83e051795025fcb98674d07eb8fe922ba4de53d39188"
    end

    resource "pytz" do
      url "https://files.pythonhosted.org/packages/d0/e1/aca6ef73a7bd322a7fc73fd99631ee3454d4fc67dc2bee463e2adf6bb3d3/pytz-2016.10.tar.bz2"
      sha256 "7016b2c4fa075c564b81c37a252a5fccf60d8964aa31b7f5eae59aeb594ae02b"
    end

    resource "requests" do
      url "https://files.pythonhosted.org/packages/5b/0b/34be574b1ec997247796e5d516f3a6b6509c4e064f2885a96ed885ce7579/requests-2.12.4.tar.gz"
      sha256 "ed98431a0631e309bb4b63c81d561c1654822cb103de1ac7b47e45c26be7ae34"
    end

    resource "snowballstemmer" do
      url "https://files.pythonhosted.org/packages/20/6b/d2a7cb176d4d664d94a6debf52cd8dbae1f7203c8e42426daa077051d59c/snowballstemmer-1.2.1.tar.gz"
      sha256 "919f26a68b2c17a7634da993d91339e288964f93c274f1343e3bbbe2096e1128"
    end

    resource "Sphinx" do
      url "https://files.pythonhosted.org/packages/b2/d5/bb4bf7fbc2e6b85d1e3832716546ecd434632d9d434a01efe87053fe5f25/Sphinx-1.5.1.tar.gz"
      sha256 "8e6a77a20b2df950de322fc32f3b508697d9d654fe984e3cc88f446a5b4c17c5"
    end
  end

  def install
    python = "python"
    version = Language::Python.major_minor_version python

    bundle_path = libexec/"lib/python#{version}/site-packages"
    ENV.prepend_create_path "PYTHONPATH", bundle_path
    resources.each do |r|
      r.stage do
        system python, *Language::Python.setup_install_args(libexec)
      end
    end

    dest_path = lib/"python#{version}/site-packages"
    dest_path.mkpath
    (dest_path/"homebrew-triqs-bundle.pth").write "#{bundle_path}\n"

    ENV.prepend_create_path "PYTHONPATH", bundle_path
    args = [
      "-DCMAKE_INSTALL_PREFIX=#{prefix}",
      "-DHDF5_ROOT=#{Formula["hdf5"].opt_prefix}",
      "-DFFTW_ROOT=#{Formula["fftw"].opt_prefix}",
      "-DPYTHON_INTERPRETER=#{python}",
      "-DBuild_Documentation=#{(build.with? "doc") ? "ON" : "OFF"}",
      "-DBuild_Tests=#{(build.with? "test") ? "ON" : "OFF"}",
    ]

    if build.with? "openblas"
      args << "-DBLA_VENDOR=OpenBLAS"
    elsif OS.mac?
      args << "-DBLA_VENDOR=Apple"
    end

    mktemp do
      system "cmake", buildpath, *args, *std_cmake_args
      make
      make "test" if build.with? "test"
      make "install"
    end
  end

  def post_install
    # This formula installs TRIQS as C++ and Python module.
    # Do not install files in bin.
    bin.rename("#{pkgshare}/bin")
  end

  test do
    python = "python"
    version = Language::Python.major_minor_version python

    # Test Python module
    (testpath/"green.py").write <<-EOS.undent
      from pytriqs.gf.local import GfImFreq, iOmega_n, inverse
      g = GfImFreq(indices = [1], beta = 50, n_points = 1000)
      g << inverse( iOmega_n + 0.5 )
      print(g(1.0))
    EOS
    system python, "#{testpath}/green.py"

    # Test C++ library
    python_prefix = `#{python} -c 'from distutils import sysconfig; import sys; sys.stdout.write(sysconfig.EXEC_PREFIX)'`
    python_lib = "#{python_prefix}/lib"
    python_inc = `#{python} -c 'from distutils import sysconfig; import sys; sys.stdout.write(sysconfig.get_python_inc())'`
    numpy_inc = `#{python} -c 'import sys, numpy; sys.stdout.write(numpy.get_include())'`
    (testpath/"green.cpp").write <<-EOS.undent
      #include <iostream>
      #include <triqs/gfs.hpp>
      using namespace triqs::gfs;
      using triqs::clef::placeholder;
      int main(int argc, char** argv)
      {
        double beta=50;
        int nw=1000;
        auto g = gf<imfreq>{{beta, Fermion, nw},{1,1}};
        placeholder<0> w_;
        g(w_) << 1/(w_+0.5);
        std::cout << g(1.0) << std::endl;
        return 0;
      }
    EOS

    lapack_flags =
      if build.with? "openblas"
        ["-isystem#{Formula["openblas"].include}", "-Lsystem#{Formula["openblas"].lib}"]
      elsif OS.mac?
        ["-framework", "Accelerate"]
      else
        ["-llapack", "-lblas"]
      end

    args = [
      "-o",
      testpath/"green",
      "-std=c++1y",
      "-I#{include}",
      "-L#{lib}",
      "-isystem#{python_inc}",
      "-isystem#{numpy_inc}",
      "-L#{python_lib}",
      *lapack_flags,
      "-ltriqs",
      "-lpython#{version}",
    ]
    system "mpic++", "#{testpath}/green.cpp", *args
    system "#{testpath}/green"
  end
end
