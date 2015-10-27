#
# Makefile for wrapping the merged archive of GAP packages
#
# update : to test with the last release in the stable branch
# stable : to test with the tip of the stable branch
# master : to test with the tip of the master branch

pkg-update:
	./mergePackages hap=stable convex=stable semigroups=stable matgrp=no

pkg-stable:
	./mergePackages hap=stable convex=stable semigroups=stable matgrp=no

pkg-master:
	./mergePackages convex=stable fining=no semigroups=stable liealgdb=no

