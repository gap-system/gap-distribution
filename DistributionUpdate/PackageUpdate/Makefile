#
# Makefile for wrapping the merged archive of GAP packages
#
# stable : to test with the head of the corresponding stable branch
# master : to test with the head of the master branch

pkg-stable:
	./mergePackages CAP=stable crypting=no DeepThought=no GeneralizedMorphismsForCAP=stable happrime=no LinearAlgebraForCAP=stable loops=stable ModulePresentationsForCAP=stable pargap=no uuid=no

pkg-master:
	./mergePackages CAP=stable DeepThought=no GeneralizedMorphismsForCAP=stable LinearAlgebraForCAP=stable liepring=no loops=stable ModulePresentationsForCAP=stable SONATA=no SymbCompCC=no
