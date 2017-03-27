#!/bin/bash
#
# SpamExperts OrangeAssassin CentOS package building script for Python 2
# Usage:
#   ./build.sh

set -e

PYTHON_BIN=/usr/bin/python

# Install fpm - helper tool to build virtualenv package into RPM
yum -y install ruby-devel rubygems gcc make rpm-build
gem install --no-ri --no-rdoc fpm

# Install package building requirements
yum -y install python-virtualenv git python-six libjpeg-turbo-devel zlib-devel
easy_install packaging appdirs virtualenv-tools

# Download OrangeAssassin Git sources
#test -e SpamPAD || git clone https://github.com/SpamExperts/SpamPAD
test -e OrangeAssassin || git clone https://github.com/SpamExperts/OrangeAssassin
sed -i OrangeAssassin/setup.py -e '/tests_require=test_requirements/d'

# Build Python virtualenv into RPM package
fpm --force --debug -n orangeassassin-python2 -s virtualenv --virtualenv-install-location /opt/ -t rpm --virtualenv-system-site-packages \
 --python-bin $PYTHON_BIN --no-virtualenv-fix-name --no-python-fix-name \
 --after-install postinst --before-remove preuninst --architecture x86_64 --maintainer "SpamExperts B.V. <support@spamexperts.com>" \
 --url "https://github.com/SpamExperts/OrangeAssassin" --description "An open-source drop-in replacement for SpamAssassin." \
 --license GPLv2 --vendor "SpamExperts B.V." --rpm-auto-add-directories --depends python --replaces spamassassin \
 --rpm-use-file-permissions --rpm-user root --rpm-group root --virtualenv-other-files-dir package_contents/ OrangeAssassin/
