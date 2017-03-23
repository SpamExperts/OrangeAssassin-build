#/bin/bash
#
# SpamExperts OrangeAssassin Debian package building script for Python2/Python3
# Usage:
#   ./build.sh

set -e

PYTHON_VERSION=2

apt-get update; apt-get install -y equivs python-dev dh-systemd python3.4-dev libjpeg-dev libghc-zlib-dev

pushd python$PYTHON_VERSION
test -e OrangeAssassin || git clone https://github.com/SpamExperts/OrangeAssassin
sed -i OrangeAssassin/setup.py -e '/tests_require=test_requirements/d'
mv OrangeAssassin/* ./

#Build the deb package
dpkg-buildpackage -us -uc                   #remove test require from setup.py
popd

