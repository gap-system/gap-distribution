#
# Makefile for wrapping the merged archive of GAP packages
#
# update : to test with the last release in the stable branch
# stable : to test with the tip of the stable branch
# master : to test with the tip of the master branch

pkg-update:
	./mergePackages hap=stable convex=stable semigroups=stable fining=no matgrp=no

pkg-stable:
	./mergePackages hap=stable convex=stable fining=no matgrp=no

pkg-master:
	./mergePackages hap=stable convex=stable fining=no liealgdb=no

