import platform
from pathlib import Path

# Available at setup time due to pyproject.toml
from pybind11.setup_helpers import Pybind11Extension, build_ext
from setuptools import setup, Extension

_DIR = Path(__file__).parent / "piper_phonemize"
__version__ = "1.2.0"

ext_modules = [
    Pybind11Extension(
        name="piper_phonemize.piper_phonemize_cpp",
        sources=[
            "src/python.cpp",
            "src/phonemize.cpp",
            "src/phoneme_ids.cpp",
            "src/tashkeel.cpp",
        ],
        include_dirs=[str(_DIR / "include"), str(_DIR / "include" / "espeak-ng"), str(_DIR / "include" / "piper-phonemize")],
        define_macros=[("VERSION_INFO", __version__)],
        library_dirs=[str(_DIR / "lib")],
        libraries=["espeak-ng", "onnxruntime"],
        extra_link_args = ["-Wl,-rpath,$ORIGIN/lib"]
    ),
]

setup(
    name="piper_phonemize",
    version=__version__,
    author="Michael Hansen",
    author_email="mike@rhasspy.org",
    url="https://github.com/rhasspy/piper-phonemize",
    description="Phonemization libary used by Piper text to speech system",
    long_description="",
    packages=["piper_phonemize"],
    package_data={
        "piper_phonemize": 
        [str(p) for p in (_DIR / "share" / "espeak-ng-data").rglob("*")] +
        [str(p) for p in (_DIR / "include").rglob("*")] +
        [str(_DIR / "share" / "libtashkeel_model.ort")] +
        [str(_DIR / "lib" / "libonnxruntime.so.1.14.1")] +
        [str(_DIR / "lib" / "libonnxruntime.so")] +
        [str(_DIR / "lib" / "libespeak-ng.so.1")] +
        [str(_DIR / "lib" / "libespeak-ng.so")] +
        [str(_DIR / "lib" / "libespeak-ng.so.1.52.0.1")]
    },
    include_package_data=True,
    ext_modules=ext_modules,
    cmdclass={"build_ext": build_ext},
    zip_safe=False,
    python_requires=">=3.12",
)
