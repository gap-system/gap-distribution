#
# Makefile for wrapping the merged archive of GAP packages
#
# stable : to test with the head of the corresponding stable branch
# master : to test with the head of the master branch

pkg-stable:
	./mergePackages only gapdoc=tip primgrp=tip smallgrp=tip transgrp=tip
	./mergePackages CAP=stable DeepThought=no GeneralizedMorphismsForCAP=stable LinearAlgebraForCAP=stable loops=stable ModulePresentationsForCAP=stable

pkg-master:
	./mergePackages only gapdoc=tip primgrp=tip smallgrp=tip transgrp=tip
	./mergePackages CAP=stable DeepThought=no GeneralizedMorphismsForCAP=stable LinearAlgebraForCAP=stable liepring=no loops=stable ModulePresentationsForCAP=stable SONATA=no SymbCompCC=no
