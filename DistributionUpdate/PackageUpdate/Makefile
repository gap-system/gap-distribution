#
# Makefile for wrapping the merged archive of GAP packages
#
# stable : to test with the head of the corresponding stable branch
# master : to test with the head of the master branch

pkg-stable:
	./mergePackages CAP=stable cohomolo=stable crypting=no example=stable float=stable GeneralizedMorphismsForCAP=stable LinearAlgebraForCAP=stable loops=stable ModulePresentationsForCAP=stable orb=4.7.6 primgrp=no semigroups=stable smallgrp=no transgrp=no uuid=no ZeroMQInterface=no

pkg-master:
	./mergePackages loops=stable
