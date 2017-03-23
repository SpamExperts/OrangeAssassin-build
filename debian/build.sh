#/bin/bash
#
# SpamExperts OrangeAssassin Debian package building script for Python2/Python3
# Usage:
#   ./build.sh

set -e

#Supports python2.7,python3.4,python3.5
PYTHON_MAJV=2
PYTHON_MINV=4

apt-get update; apt-get install -y libghc-zlib-dev

pushd python$PYTHON_MAJV
test -e OrangeAssassin || git clone https://github.com/SpamExperts/OrangeAssassin
sed -i OrangeAssassin/setup.py -e '/tests_require=test_requirements/d'
mv OrangeAssassin/* ./
rm OrangeAssassin/ -r

if [ $PYTHON_MAJV -eq 3 ]
then 
    if [ $PYTHON_MINV -eq 5 ]
    then
        sed -i 's/3\.4/3\.5/g' debian/control
    else
        sed -i 's/3\.5/3\.4/g' debian/control
    fi
fi

#Build the deb package
dpkg-buildpackage -us -uc                   #remove test require from setup.py
cd python$PYTHON_MAJV
rm docs/ oa/ requirements/ scripts/ tests/ -r

