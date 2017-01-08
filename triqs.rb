class Triqs < Formula
  include Language::Python::Virtualenv

  desc "Toolbox for Research on Interacting Quantum Systems"
  homepage "https://triqs.ipht.cnrs.fr"
  url "https://github.com/TRIQS/triqs/archive/1.3.2.tar.gz"
  sha256 "5a59f2fd6256cd09ece12718bd56ed8218ea091c3001ff14f08693206bca74b3"

  needs :cxx11

  option "with-doc", "Build documentation"
  option "with-test", "Build tests"
  option "with-venv", "Build the python modules into the virtualenv"

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build

  depends_on :fortran
  depends_on :mpi => [:cc, :cxx]

  depends_on "boost" => "with-mpi"
  depends_on "boost-python"
  depends_on "openblas" => (OS.mac? ? :optional : :recommended)
  depends_on "fftw"
  depends_on "gmp"
  depends_on "hdf5" => "without-mpi"
  depends_on "doxygen" if build.with? "doc"

  depends_on :python
  depends_on "virtualenv" => :python

  depends_on "homebrew/python/numpy"
  depends_on "homebrew/python/scipy"
  depends_on "homebrew/python/matplotlib"

  if build.without? "venv"
    depends_on "traitlets" => :python
    depends_on "ipython" => :python
    depends_on "jupyter" => :python
    depends_on "six" => :python
    depends_on "h5py" => :python
    depends_on "mpi4py" => :python
    depends_on "jinja2" => :python
    depends_on "tornado" => :python
    depends_on "zmq" => :python
    depends_on "mako" => :python
    depends_on "mpi4py" => :python
  end

  patch :DATA

  resource "backports_abc" do
    url "https://files.pythonhosted.org/packages/68/3c/1317a9113c377d1e33711ca8de1e80afbaf4a3c950dd0edfaf61f9bfe6d8/backports_abc-0.5.tar.gz"
    sha256 "033be54514a03e255df75c5aee8f9e672f663f93abb723444caec8fe43437bde"
  end

  resource "backports.shutil_get_terminal_size" do
    url "https://files.pythonhosted.org/packages/ec/9c/368086faa9c016efce5da3e0e13ba392c9db79e3ab740b763fe28620b18b/backports.shutil_get_terminal_size-1.0.0.tar.gz"
    sha256 "713e7a8228ae80341c70586d1cc0a8caa5207346927e23d09dcbcaf18eadec80"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/4f/75/e1bc6e363a2c76f8d7e754c27c437dbe4086414e1d6d2f6b2a3e7846f22b/certifi-2016.9.26.tar.gz"
    sha256 "8275aef1bbeaf05c53715bfc5d8569bd1e04ca1e8e69608cc52bcaac2604eb19"
  end

  resource "Cython" do
    url "https://files.pythonhosted.org/packages/b7/67/7e2a817f9e9c773ee3995c1e15204f5d01c8da71882016cac10342ef031b/Cython-0.25.2.tar.gz"
    sha256 "f141d1f9c27a07b5a93f7dc5339472067e2d7140d1c5a9e20112a5665ca60306"
  end

  resource "decorator" do
    url "https://files.pythonhosted.org/packages/13/8a/4eed41e338e8dcc13ca41c94b142d4d20c0de684ee5065523fee406ce76f/decorator-4.0.10.tar.gz"
    sha256 "9c6e98edcb33499881b86ede07d9968c81ab7c769e28e9af24075f0a5379f070"
  end

  resource "enum34" do
    url "https://files.pythonhosted.org/packages/bf/3e/31d502c25302814a7c2f1d3959d2a3b3f78e509002ba91aea64993936876/enum34-1.1.6.tar.gz"
    sha256 "8ad8c4783bf61ded74527bffb48ed9b54166685e4230386a9ed9b1279e2df5b1"
  end

  resource "h5py" do
    url "https://files.pythonhosted.org/packages/22/82/64dada5382a60471f85f16eb7d01cc1a9620aea855cd665609adf6fdbb0d/h5py-2.6.0.tar.gz"
    sha256 "b2afc35430d5e4c3435c996e4f4ea2aba1ea5610e2d2f46c9cae9f785e33c435"
  end

  resource "ipython" do
    url "https://files.pythonhosted.org/packages/89/63/a9292f7cd9d0090a0f995e1167f3f17d5889dcbc9a175261719c513b9848/ipython-5.1.0.tar.gz"
    sha256 "7ef4694e1345913182126b219aaa4a0047e191af414256da6772cf249571b961"
  end

  resource "ipython_genutils" do
    url "https://files.pythonhosted.org/packages/71/b7/a64c71578521606edbbce15151358598f3dfb72a3431763edc2baf19e71f/ipython_genutils-0.1.0.tar.gz"
    sha256 "3a0624a251a26463c9dfa0ffa635ec51c4265380980d9a50d65611c3c2bd82a6"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/de/24/bad6dc9f0d7a0f835d940c5f5076f29824fce45ccd673cc843abf30b9117/Jinja2-2.9.2.tar.gz"
    sha256 "2333eae399fb538f934d661f7debab8a9736002c343c8e95c56f1e413076c0ce"
  end

  resource "Mako" do
    url "https://files.pythonhosted.org/packages/56/4b/cb75836863a6382199aefb3d3809937e21fa4cb0db15a4f4ba0ecc2e7e8e/Mako-1.0.6.tar.gz"
    sha256 "48559ebd872a8e77f92005884b3d88ffae552812cdf17db6768e5c3be5ebbe0d"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz"
    sha256 "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3"
  end

  resource "mpi4py" do
    url "https://files.pythonhosted.org/packages/ee/b8/f443e1de0b6495479fc73c5863b7b5272a4ece5122e3589db6cd3bb57eeb/mpi4py-2.0.0.tar.gz"
    sha256 "6543a05851a7aa1e6d165e673d422ba24e45c41e4221f0993fe1e5924a00cb81"
  end

  resource "pathlib2" do
    url "https://files.pythonhosted.org/packages/c9/27/8448b10d8440c08efeff0794adf7d0ed27adb98372c70c7b38f3947d4749/pathlib2-2.1.0.tar.gz"
    sha256 "deb3a960c1d55868dfbcac98432358b92ba89d95029cddd4040db1f27405055c"
  end

  resource "pexpect" do
    url "https://files.pythonhosted.org/packages/e8/13/d0b0599099d6cd23663043a2a0bb7c61e58c6ba359b2656e6fb000ef5b98/pexpect-4.2.1.tar.gz"
    sha256 "3d132465a75b57aa818341c6521392a06cc660feb3988d7f1074f39bd23c9a92"
  end

  resource "pickleshare" do
    url "https://files.pythonhosted.org/packages/69/fe/dd137d84daa0fd13a709e448138e310d9ea93070620c9db5454e234af525/pickleshare-0.7.4.tar.gz"
    sha256 "84a9257227dfdd6fe1b4be1319096c20eb85ff1e82c7932f36efccfe1b09737b"
  end

  resource "prompt_toolkit" do
    url "https://files.pythonhosted.org/packages/83/14/5ac258da6c530eca02852ee25c7a9ff3ca78287bb4c198d0d0055845d856/prompt_toolkit-1.0.9.tar.gz"
    sha256 "cd6523b36adc174cc10d54b1193eb626b4268609ff6ea92c15bcf1996609599c"
  end

  resource "ptyprocess" do
    url "https://files.pythonhosted.org/packages/db/d7/b465161910f3d1cef593c5e002bff67e0384898f597f1a7fdc8db4c02bf6/ptyprocess-0.5.1.tar.gz"
    sha256 "0530ce63a9295bfae7bd06edc02b6aa935619f486f0f1dc0972f516265ee81a6"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/b8/67/ab177979be1c81bc99c8d0592ef22d547e70bb4c6815c383286ed5dec504/Pygments-2.1.3.tar.gz"
    sha256 "88e4c8a91b2af5962bfa5ea2447ec6dd357018e86e94c7d14bd8cacbc5b55d81"
  end

  resource "pyzmq" do
    url "https://files.pythonhosted.org/packages/af/37/8e0bf3800823bc247c36715a52e924e8f8fd5d1432f04b44b8cd7a5d7e55/pyzmq-16.0.2.tar.gz"
    sha256 "0322543fff5ab6f87d11a8a099c4c07dd8a1719040084b6ce9162bcdf5c45c9d"
  end

  resource "simplegeneric" do
    url "https://files.pythonhosted.org/packages/3d/57/4d9c9e3ae9a255cd4e1106bb57e24056d3d0709fc01b2e3e345898e49d5b/simplegeneric-0.8.1.zip"
    sha256 "dc972e06094b9af5b855b3df4a646395e43d1c9d0d39ed345b7393560d0b9173"
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

  resource "traitlets" do
    url "https://files.pythonhosted.org/packages/b1/d6/5b5aa6d5c474691909b91493da1e8972e309c9f01ecfe4aeafd272eb3234/traitlets-4.3.1.tar.gz"
    sha256 "ba8c94323ccbe8fd792e45d8efe8c95d3e0744cc8c085295b607552ab573724c"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/55/11/e4a2bb08bb450fdbd42cc709dd40de4ed2c472cf0ccb9e64af22279c5495/wcwidth-0.1.7.tar.gz"
    sha256 "3df37372226d6e63e1b1e1eda15c594bca98a22d33a23832a90998faa96bc65e"
  end

  resource "zmq" do
    url "https://files.pythonhosted.org/packages/6e/78/833b2808793c1619835edb1a4e17a023d5d625f4f97ff25ffff986d1f472/zmq-0.0.0.tar.gz"
    sha256 "6b1a1de53338646e8c8405803cffb659e8eb7bb02fff4c9be62a7acfac8370c9"
  end

  def install
    #python_packages = %w[traitlets ipython jupyter six h5py mpi4py jinja2 tornado zmq mako mpi4py]
    #if build.with? "doc"
    #  python_packages << "sphinx" << "pyparsing" << "clang"
    #end

    #venv_path = "#{libexec}/venv"
    venv_path = libexec
    venv = virtualenv_create(venv_path, "python")
    #venv.pip_install python_packages
    venv.pip_install resources

    args = [
      "-DBuild_Documentation=#{(build.with? "doc") ? "ON" : "OFF"}",
      "-DBuild_Tests=#{(build.with? "test") ? "ON" : "OFF"}",
      "-DHDF5_ROOT=#{HOMEBREW_PREFIX}",
      "-DFFTW_ROOT=#{HOMEBREW_PREFIX}",
      "-DBLA_VENDOR=#{(build.with? "openblas") ? "OpenBLAS" : "Apple"}",
      "-DPYTHON_INTERPRETER=#{venv_path}/bin/python",
    ]

    mkdir "build" do
      system "cmake", "..", *args, *std_cmake_args
      system "make"
      system "make", "test" if build.with? "test"
      system "make", "install"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test triqs`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
__END__
--- a/CMakeLists.txt	2016-06-20 21:01:56.000000000 -0400
+++ b/CMakeLists.txt	2017-01-05 21:02:39.000000000 -0500
@@ -291,12 +291,12 @@
 if(HDF5_IS_PARALLEL)
  message(FATAL_ERROR "parallel(MPI) hdf5 is detected. The standard version is preferred.")
 endif(HDF5_IS_PARALLEL)
-message( STATUS " HDF5_LIBRARIES = ${HDF5_LIBRARIES} ")
+message( STATUS " HDF5_LIBRARIES = ${HDF5_LIBRARIES} ${HDF5_HL_LIBRARIES}")
 mark_as_advanced(HDF5_DIR) # defined somewhere else ? what is it ?
 
 include_directories (SYSTEM ${HDF5_INCLUDE_DIR})
 #link_libraries (${HDF5_LIBRARIES}) 
-set(TRIQS_LIBRARY_HDF5  ${HDF5_LIBRARIES})
+set(TRIQS_LIBRARY_HDF5 ${HDF5_LIBRARIES} ${HDF5_HL_LIBRARIES})
 set(TRIQS_INCLUDE_HDF5 ${HDF5_INCLUDE_DIR})
 set(TRIQS_CXX_DEFINITIONS ${TRIQS_CXX_DEFINITIONS} ${HDF5_DEFINITIONS})
 set(TRIQS_HDF5_DIFF_EXECUTABLE ${HDF5_DIFF_EXECUTABLE})
