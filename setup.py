# -*- coding: utf-8 -*-
"""install panoramix and deploy source-dist and wheel to pypi.python.org.
deps (requires recent version):
    *) pip install --upgrade pip wheel setuptools twine
publish to pypi w/o having to convert Readme.md to RST:
    1) #> python setup.py sdist bdist_wheel
    2) #> twine upload dist/*   #<specify bdist_wheel version to upload>; #optional --repository <testpypi> or  --repository-url <testpypi-url>
"""
from setuptools import setup, find_packages
from setuptools.command.install import install
import sys
import os
import io

# Package meta-data.
NAME = "panoramix-decompiler"
DESCRIPTION = "Decompiler at the heart of Eveem.org https://www.eveem.org/"
URL = "https://github.com/palkeo/panoramix"
AUTHOR = "Tomasz Kolinko / palkeo"
AUTHOR_EMAIL = "panoramix@palkeo.com"
REQUIRES_PYTHON = ">3.8.0"


# What packages are required for this module to be executed?
REQUIRED = [
    "coloredlogs",
    "requests",
    "web3",
    "timeout_decorator",
    "appdirs",
]

TESTS_REQUIRE = []

# What packages are optional?
EXTRAS = {
    # 'fancy feature': ['django'],
}

VERSION = "0.4"

here = os.path.abspath(os.path.dirname(__file__))

# Import the README and use it as the long-description.
# Note: this will only work if 'README.md' is present in your MANIFEST.in file!
try:
    with io.open(os.path.join(here, "README.md"), encoding="utf-8") as f:
        long_description = "\n" + f.read()
except FileNotFoundError:
    long_description = DESCRIPTION

setup(
    name=NAME,
    version=VERSION,
    description=DESCRIPTION,
    long_description=long_description,
    long_description_content_type="text/markdown",  # requires twine and recent setuptools
    url=URL,
    author=AUTHOR,
    author_email=AUTHOR_EMAIL,
    license="MIT",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Intended Audience :: Science/Research",
        "Topic :: Software Development :: Disassemblers",
        "Programming Language :: Python :: 3.8",
    ],
    keywords="ethereum evm decompiler Eveem.org",
    packages=find_packages(exclude=["contrib", "docs", "tests"]),
    install_requires=REQUIRED,
    tests_require=TESTS_REQUIRE,
    python_requires=REQUIRES_PYTHON,
    extras_require=EXTRAS,
    include_package_data=True,
    entry_points={"console_scripts": ["panoramix=panoramix.__main__:main"]}, # deploy panoramix shell command
)
