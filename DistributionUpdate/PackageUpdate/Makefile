#
# Makefile for wrapping the merged archive of GAP packages
#
# update : to test with the last release in the corresponding stable branch
# stable : to test with the head of the corresponding stable branch
# master : to test with the head of the master branch

pkg-update:
	./mergePackages semigroups=stable

pkg-stable:
	./mergePackages semigroups=stable

pkg-master:
	./mergePackages semigroups=no
