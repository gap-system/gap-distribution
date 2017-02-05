#
# Makefile for wrapping the GAP release
#
# update: based on the tag of the last release in the corresponding stable branch
# minor : based on the head of the corresponding stable branch
# major : based on the head of the master branch

update:
	cp setvarupdate setvar
	./doit

minor:
	cp setvarminor setvar
	./doit

major:
	cp setvarmajor setvar
	./doit

clean:
	rm setvar
