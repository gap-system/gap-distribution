#
# Makefile for wrapping the merged archive of GAP packages
#
# stable : to test with the head of the corresponding stable branch
# master : to test with the head of the master branch

pkg-stable:
	./mergePackages CAP=stable GeneralizedMorphismsForCAP=stable LinearAlgebraForCAP=stable loops=stable ModulePresentationsForCAP=stable

pkg-master:
	./mergePackages CAP=stable GeneralizedMorphismsForCAP=stable LinearAlgebraForCAP=stable loops=stable ModulePresentationsForCAP=stable SONATA=no
