class Triqs < Formula
  include Language::Python::Virtualenv

  desc "A Toolbox for Research on Interacting Quantum Systems"
  homepage "https://triqs.ipht.cnrs.fr"
  url "https://github.com/TRIQS/triqs/archive/1.3.2.tar.gz"
  version "1.3.2"
  sha256 "5a59f2fd6256cd09ece12718bd56ed8218ea091c3001ff14f08693206bca74b3"

  needs :cxx11

  option "with-doc", "Build documentation"
  option "with-test", "Build tests"

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
  depends_on "numpy" => :python
  depends_on "matplotlib" => :python
  depends_on "scipy" => :python

  depends_on "h5py" => :python
  depends_on "mpi4py" => :python

  patch :DATA

  def install
    python_packages = ["ipython", "jupyter", "jinja2", "tornado", "zmq", "mako"]
    if build.with? "doc"
      python_packages << "sphinx" << "pyparsing" << "clang"
    end

    venv_path = "#{libexec}/venv"
    venv = virtualenv_create(venv_path, "python")
    venv.pip_install python_packages

    system "virtualenv", venv_path
    system "#{venv_path}/bin/pip", "install", *python_packages
   
    args = []
    args << "-DBuild_Documentation=#{(build.with? "doc") ? "ON" : "OFF"}"
    args << "-DBuild_Tests=#{(build.with? "test") ? "ON" : "OFF"}"
    args << "-DHDF5_ROOT=#{HOMEBREW_PREFIX}"
    args << "-DFFTW_ROOT=#{HOMEBREW_PREFIX}"
    args << "-DBLA_VENDOR=#{(build.with? "openblas") ? "OpenBLAS" : "Apple"}"
    args << "-DPYTHON_INTERPRETER=#{venv_path}/bin/python"

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
