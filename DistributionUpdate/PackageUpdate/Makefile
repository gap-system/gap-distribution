#
# Makefile for wrapping the merged archive of GAP packages
#
# stable : to test with the head of the corresponding stable branch
# master : to test with the head of the master branch
#
# 'required' versions wrap only packages which are required to run GAP
#

pkg-stable:
	./mergePackages CAP=stable GeneralizedMorphismsForCAP=stable groupoids=stable LinearAlgebraForCAP=stable ModulePresentationsForCAP=stable semigroups=stable

pkg-required-stable:
	./mergePackages only gapdoc=tip primgrp=tip smallgrp=tip transgrp=tip

pkg-master:
	./mergePackages CAP=stable GeneralizedMorphismsForCAP=stable groupoids=stable LinearAlgebraForCAP=stable ModulePresentationsForCAP=stable semigroups=stable SONATA=no

pkg-required-master:
	./mergePackages only gapdoc=tip primgrp=tip smallgrp=tip transgrp=tip
