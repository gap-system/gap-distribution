#
# Makefile for wrapping the merged archive of GAP packages
#
# update : to test with the last release in the corresponding stable branch
# stable : to test with the head of the corresponding stable branch
# master : to test with the head of the master branch

pkg-update:
	./mergePackages cohomolo=stable crypting=no float=stable gpd=no hap=stable loops=stable primgrp=no semigroups=stable smallgrp=no transgrp=no uuid=no ZeroMQInterface=no

pkg-stable:
	./mergePackages cohomolo=stable crypting=no float=stable gpd=no hap=stable loops=stable primgrp=no semigroups=stable smallgrp=no transgrp=no uuid=no ZeroMQInterface=no

pkg-master:
	./mergePackages gpd=no hap=stable loops=stable
