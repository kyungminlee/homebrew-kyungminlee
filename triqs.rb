class Triqs < Formula
  include Language::Python::Virtualenv

  desc "Toolbox for Research on Interacting Quantum Systems"
  homepage "https://triqs.ipht.cnrs.fr"
  url "https://github.com/TRIQS/triqs/archive/1.3.2.tar.gz"
  sha256 "5a59f2fd6256cd09ece12718bd56ed8218ea091c3001ff14f08693206bca74b3"
  head "https://github.com/TRIQS/triqs.git"

  needs :cxx11

  option "with-doc", "Build documentation"
  option "with-test", "Verify the build with `make test`"
  option "without-venv", "Do not create virtualenv"

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

  if build.without? "venv"
    depends_on "numpy" => :python
    depends_on "scipy" => :python
    depends_on "matplotlib" => :python

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
    if build.with? "doc"
      depends_on "clang" => :python
      depends_on "pyparsing" => :python
      depends_on "sphinx" => :python
    end
  else
    depends_on "homebrew/python/numpy"
    depends_on "homebrew/python/scipy"
    depends_on "homebrew/python/matplotlib"

    depends_on "zeromq" => (OS.mac? ? :optional : :recommended)

    resource "backports_abc" do
      url "https://files.pythonhosted.org/packages/68/3c/1317a9113c377d1e33711ca8de1e80afbaf4a3c950dd0edfaf61f9bfe6d8/backports_abc-0.5.tar.gz"
      sha256 "033be54514a03e255df75c5aee8f9e672f663f93abb723444caec8fe43437bde"
    end

    resource "backports.shutil_get_terminal_size" do
      url "https://files.pythonhosted.org/packages/ec/9c/368086faa9c016efce5da3e0e13ba392c9db79e3ab740b763fe28620b18b/backports.shutil_get_terminal_size-1.0.0.tar.gz"
      sha256 "713e7a8228ae80341c70586d1cc0a8caa5207346927e23d09dcbcaf18eadec80"
    end

    resource "bleach" do
      url "https://files.pythonhosted.org/packages/99/00/25a8fce4de102bf6e3cc76bc4ea60685b2fee33bde1b34830c70cacc26a7/bleach-1.5.0.tar.gz"
      sha256 "978e758599b54cd3caa2e160d74102879b230ea8dc93871d0783721eef58bc65"
    end

    resource "certifi" do
      url "https://files.pythonhosted.org/packages/4f/75/e1bc6e363a2c76f8d7e754c27c437dbe4086414e1d6d2f6b2a3e7846f22b/certifi-2016.9.26.tar.gz"
      sha256 "8275aef1bbeaf05c53715bfc5d8569bd1e04ca1e8e69608cc52bcaac2604eb19"
    end

    resource "configparser" do
      url "https://files.pythonhosted.org/packages/7c/69/c2ce7e91c89dc073eb1aa74c0621c3eefbffe8216b3f9af9d3885265c01c/configparser-3.5.0.tar.gz"
      sha256 "5308b47021bc2340965c371f0f058cc6971a04502638d4244225c49d80db273a"
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

    resource "functools32" do
      url "https://files.pythonhosted.org/packages/c5/60/6ac26ad05857c601308d8fb9e87fa36d0ebf889423f47c3502ef034365db/functools32-3.2.3-2.tar.gz"
      sha256 "f6253dfbe0538ad2e387bd8fdfd9293c925d63553f5813c4e587745416501e6d"
    end

    resource "h5py" do
      url "https://files.pythonhosted.org/packages/22/82/64dada5382a60471f85f16eb7d01cc1a9620aea855cd665609adf6fdbb0d/h5py-2.6.0.tar.gz"
      sha256 "b2afc35430d5e4c3435c996e4f4ea2aba1ea5610e2d2f46c9cae9f785e33c435"
    end

    resource "html5lib" do
      url "https://files.pythonhosted.org/packages/ae/ae/bcb60402c60932b32dfaf19bb53870b29eda2cd17551ba5639219fb5ebf9/html5lib-0.9999999.tar.gz"
      sha256 "2612a191a8d5842bfa057e41ba50bbb9dcb722419d2408c78cff4758d0754868"
    end

    resource "ipykernel" do
      url "https://files.pythonhosted.org/packages/2d/1b/eee47b5cd8b2fcdde587cad1e8d3f7eae7bdfa1d36a94ad316fc5fbee833/ipykernel-4.5.2.tar.gz"
      sha256 "5a54f25f0e6c8ee74c362c23f9a95e10e74c6b7f5ef42059c861ff6f26d89462"
    end

    resource "ipython" do
      url "https://files.pythonhosted.org/packages/89/63/a9292f7cd9d0090a0f995e1167f3f17d5889dcbc9a175261719c513b9848/ipython-5.1.0.tar.gz"
      sha256 "7ef4694e1345913182126b219aaa4a0047e191af414256da6772cf249571b961"
    end

    resource "ipython_genutils" do
      url "https://files.pythonhosted.org/packages/71/b7/a64c71578521606edbbce15151358598f3dfb72a3431763edc2baf19e71f/ipython_genutils-0.1.0.tar.gz"
      sha256 "3a0624a251a26463c9dfa0ffa635ec51c4265380980d9a50d65611c3c2bd82a6"
    end

    resource "ipywidgets" do
      url "https://files.pythonhosted.org/packages/51/b1/81b0f4ad11922a8180ce20496af28d67ecd1232fb5ad472088542bea0fae/ipywidgets-5.2.2.tar.gz"
      sha256 "baf6098f054dd5eacc2934b8ea3bef908b81ca8660d839f1f940255a72c660d2"
    end

    resource "Jinja2" do
      url "https://files.pythonhosted.org/packages/de/24/bad6dc9f0d7a0f835d940c5f5076f29824fce45ccd673cc843abf30b9117/Jinja2-2.9.2.tar.gz"
      sha256 "2333eae399fb538f934d661f7debab8a9736002c343c8e95c56f1e413076c0ce"
    end

    resource "jsonschema" do
      url "https://files.pythonhosted.org/packages/58/0d/c816f5ea5adaf1293a1d81d32e4cdfdaf8496973aa5049786d7fdb14e7e7/jsonschema-2.5.1.tar.gz"
      sha256 "36673ac378feed3daa5956276a829699056523d7961027911f064b52255ead41"
    end

    resource "jupyter" do
      url "https://files.pythonhosted.org/packages/c9/a9/371d0b8fe37dd231cf4b2cff0a9f0f25e98f3a73c3771742444be27f2944/jupyter-1.0.0.tar.gz"
      sha256 "d9dc4b3318f310e34c82951ea5d6683f67bed7def4b259fafbfe4f1beb1d8e5f"
    end

    resource "jupyter_client" do
      url "https://files.pythonhosted.org/packages/88/03/d8e218721af0b084d4fda5e3bb89dc201505780f96ae060bf5e3e67c7707/jupyter_client-4.4.0.tar.gz"
      sha256 "c99a52fac2e5b7a3b714e9252ebf72cbf97536d556ae2b5082baccc3e5cd52ee"
    end

    resource "jupyter_console" do
      url "https://files.pythonhosted.org/packages/05/d6/64a59934c7fb8bf46e8b42bf6b21015643d9dd02e52234c7c8bc929dec5e/jupyter_console-5.0.0.tar.gz"
      sha256 "7ddfc8cc49921b0ed852500928922e637f9188358c94b5c76339a5a8f9ac4c11"
    end

    resource "jupyter_core" do
      url "https://files.pythonhosted.org/packages/bc/d0/8f57f733913fbd4ce1a01991b008bace8dcf05158080821c6de76b4c5d01/jupyter_core-4.2.1.tar.gz"
      sha256 "89c55399c8437f777197c2c82c1ff5639c7f71d4eb2f172a81afa120b68dc7b3"
    end

    resource "Mako" do
      url "https://files.pythonhosted.org/packages/56/4b/cb75836863a6382199aefb3d3809937e21fa4cb0db15a4f4ba0ecc2e7e8e/Mako-1.0.6.tar.gz"
      sha256 "48559ebd872a8e77f92005884b3d88ffae552812cdf17db6768e5c3be5ebbe0d"
    end

    resource "MarkupSafe" do
      url "https://files.pythonhosted.org/packages/c0/41/bae1254e0396c0cc8cf1751cb7d9afc90a602353695af5952530482c963f/MarkupSafe-0.23.tar.gz"
      sha256 "a4ec1aff59b95a14b45eb2e23761a0179e98319da5a7eb76b56ea8cdc7b871c3"
    end

    resource "mistune" do
      url "https://files.pythonhosted.org/packages/88/1e/be99791262b3a794332fda598a07c2749a433b9378586361ba9d8e824607/mistune-0.7.3.tar.gz"
      sha256 "21d0e869df3b9189f248e022f1c9763cf9069e1a2f00676f1f1852bd7f98b713"
    end

    resource "mpi4py" do
      url "https://files.pythonhosted.org/packages/ee/b8/f443e1de0b6495479fc73c5863b7b5272a4ece5122e3589db6cd3bb57eeb/mpi4py-2.0.0.tar.gz"
      sha256 "6543a05851a7aa1e6d165e673d422ba24e45c41e4221f0993fe1e5924a00cb81"
    end

    resource "nbconvert" do
      url "https://files.pythonhosted.org/packages/c9/d2/ad84c7d3ca5427b4b4cf8afefc827826f1311e00b47d534d7d01f693037c/nbconvert-5.0.0.tar.gz"
      sha256 "b5ed2c356692e8675ad5078c674d8a177a2eaa1cd662c14dc0b4fb7f0fa64e5c"
    end

    resource "nbformat" do
      url "https://files.pythonhosted.org/packages/81/63/5cb425bfa9cff370a740c8d6fd26f17c7db152c1877aca3e7671ecfa8ce3/nbformat-4.2.0.tar.gz"
      sha256 "389a5b630a30539074f238a48fb9864592f63d611baccfa2ffaf14ffe239de06"
    end

    resource "notebook" do
      url "https://files.pythonhosted.org/packages/d8/1f/2a79c0e0759421638287057276ce7d0f64baad5a50932da1ac963b54c9ab/notebook-4.3.1.tar.gz"
      sha256 "922b911f3cd1b20cf37d5ac365521586678fca4b8d20476fc369907b4a0ae1af"
    end

    resource "pandocfilters" do
      url "https://files.pythonhosted.org/packages/e3/1f/21d1b7e8ca571e80b796c758d361fdf5554335ff138158654684bc5401d8/pandocfilters-1.4.1.tar.gz"
      sha256 "ec8bcd100d081db092c57f93462b1861bcfa1286ef126f34da5cb1d969538acd"
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

    resource "qtconsole" do
      url "https://files.pythonhosted.org/packages/2b/94/ed3d11ab0ceac135f22fe418a9d5f99c4a071f74b5bd46c4f2ede65eafb1/qtconsole-4.2.1.tar.gz"
      sha256 "25ec7d345528b3e8f3c91be349dd3c699755f206dc4b6ec668e2e5dd60ea18ef"
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

    resource "terminado" do
      url "https://files.pythonhosted.org/packages/58/59/aabe84fce2f45da10165435cec204d982863e176f6849a4a4fe2652a20a8/terminado-0.6.tar.gz"
      sha256 "2c0ba1f624067dccaaead7d2247cfe029806355cef124dc2ccb53c83229f0126"
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

    resource "widgetsnbextension" do
      url "https://files.pythonhosted.org/packages/a2/0f/7044b0de3709d9564248dd124209348c4f3b1dae0143aa272f8a2abe04ce/widgetsnbextension-1.2.6.tar.gz"
      sha256 "c618cfb32978c9517caf0b4ef3aec312f8dd138577745e7b0d4abfcc7315ce51"
    end

    resource "zmq" do
      url "https://files.pythonhosted.org/packages/6e/78/833b2808793c1619835edb1a4e17a023d5d625f4f97ff25ffff986d1f472/zmq-0.0.0.tar.gz"
      sha256 "6b1a1de53338646e8c8405803cffb659e8eb7bb02fff4c9be62a7acfac8370c9"
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
  end

  stable do
    # CMakeLists.txt
    # https://github.com/TRIQS/triqs/commit/acab58a59375028f5fee907dbc3d80de1ef496ae
    # Safe to remove when the next stable release is out
    patch :DATA
  end

  def install
    if build.with? "venv"
      venv_root = libexec
      venv = virtualenv_create(venv_root, "python")

      # Wheel only packages. Currently not supported by pip_install
      pkgs = %w[entrypoints testpath]
      system "#{venv_root}/bin/pip", "install", "-v", "--no-deps", "--ignore-installed", *pkgs

      venv.pip_install resources
    end
    args = [
      "-DBuild_Documentation=#{(build.with? "doc") ? "ON" : "OFF"}",
      "-DBuild_Tests=#{(build.with? "test") ? "ON" : "OFF"}",
      "-DHDF5_ROOT=#{HOMEBREW_PREFIX}",
      "-DFFTW_ROOT=#{HOMEBREW_PREFIX}",
      "-DBLA_VENDOR=#{(build.with? "openblas") ? "OpenBLAS" : "Apple"}",
    ]

    args << "-DPYTHON_INTERPRETER=#{venv_root}/bin/python" if build.with? "venv"

    mkdir "build" do
      system "cmake", "..", *args, *std_cmake_args
      system "make"
      system "make", "test" if build.with? "test"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/pytriqs", "-c", "import pytriqs.gf.local"
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
--- a/shells/pytriqs.bash.in	2017-01-08 14:32:01.375670900 -0500
+++ b/shells/pytriqs.bash.in	2017-01-08 14:32:52.796944500 -0500
@@ -1,4 +1,4 @@
 #!/bin/bash
 @EXPORT_PYTHONPATH@
 
-@PYTHON_INTERPRETER@ $@
+@PYTHON_INTERPRETER@ "$@"
--- a/shells/ipytriqs.bash.in	2017-01-08 14:32:07.848841200 -0500
+++ b/shells/ipytriqs.bash.in	2017-01-08 14:32:43.176291600 -0500
@@ -7,4 +7,4 @@
 assert IPython.__version__ >= '2' , 'ipython version too low: need 2.x or higher for the notebook' 
 from IPython.frontend.terminal.ipapp import launch_new_instance
 sys.exit(launch_new_instance())
-" $@
+" "$@"
--- a/shells/ipytriqs_notebook.bash.in	2017-01-08 14:32:17.036621600 -0500
+++ b/shells/ipytriqs_notebook.bash.in	2017-01-08 14:32:48.526354500 -0500
@@ -14,4 +14,4 @@
   sys.argv.insert(2, '--MappingKernelManager.time_to_dead=3600')
 from IPython.frontend.terminal.ipapp import launch_new_instance
 sys.exit(launch_new_instance())
-" $@
+" "$@"
