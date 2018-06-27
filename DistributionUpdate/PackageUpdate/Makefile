#
# Makefile for wrapping the merged archive of GAP packages
#
# stable : to test with the head of the corresponding stable branch
# master : to test with the head of the master branch
#
# 'required' versions wrap only packages which are required to run GAP
#

pkg-stable:
	./mergePackages CAP=stable DeepThought=no GeneralizedMorphismsForCAP=stable LinearAlgebraForCAP=stable loops=stable ModulePresentationsForCAP=stable

pkg-required-stable:
	./mergePackages only gapdoc=tip primgrp=tip smallgrp=tip transgrp=tip

pkg-master:
	./mergePackages CAP=stable DeepThought=no GeneralizedMorphismsForCAP=stable LinearAlgebraForCAP=stable liepring=no loops=stable ModulePresentationsForCAP=stable SONATA=no SymbCompCC=no

pkg-required-master:
	./mergePackages only gapdoc=tip primgrp=tip smallgrp=tip transgrp=tip
