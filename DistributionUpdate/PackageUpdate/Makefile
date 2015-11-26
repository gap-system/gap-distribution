#
# Makefile for wrapping the merged archive of GAP packages
#
# update : to test with the last release in the stable branch
# stable : to test with the tip of the stable branch
# master : to test with the tip of the master branch

pkg-update:
	./mergePackages convex=stable semigroups=stable matgrp=no \
	CAP=no GeneralizedMorphismsForCAP=no LinearAlgebraForCAP=no ModulePresentationsForCAP=no

pkg-stable:
	./mergePackages convex=stable semigroups=stable matgrp=no \
	CAP=no GeneralizedMorphismsForCAP=no LinearAlgebraForCAP=no ModulePresentationsForCAP=no

pkg-master:
	./mergePackages convex=stable semigroups=stable liealgdb=no

