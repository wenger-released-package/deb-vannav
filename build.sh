#!/bin/bash

pkg_name=vannav
pkg_arch=amd64
pkg_version=1.12.2
pkg_release=3
pkg_maintainer="Wenger Binning <Wengerbinning@gmail.com>"

src=./
dst=$pkg_name-$pkg_arch-$pkg_version-$pkg_release

test -d $dst && rm -rf $dst
mkdir -p $dst

#
install -m 755 -d $dst/usr/bin
install -m 755 -t $dst/usr/bin $src/nav
install -m 755 -d $dst/etc/systemd/system
install -m 655 -t $dst/etc/systemd/system $src/vannav.service
install -m 755 -d $dst/DEBIAN

#
cat > $dst/DEBIAN/control <<EOF
Package: $pkg_name
Architecture: $pkg_arch
Version: $pkg_version-$pkg_release
Maintainer: $pkg_maintainer
Description: The NAV Service.
        https://github.com/Mereithhh/van-nav
EOF

#
dpkg-deb --root-owner-group --build $dst