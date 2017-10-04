# Release wrapping scripts

This directory contains scrips to prepare release candidates for the
next minor, major and update releases. Its `PackageUpdate` subdirectory
contains scripts for the package update mechanism. They are documented
separately in `PackageUpdate/README.md`.


## Definitions

Assuming that the latest official GAP release has version 4.X.Y, we have:

* Minor release: version 4.X.Y+1, based on the head of the stable-4.X branch

* Major release: version 4.X+1.0, based on the head of the master branch

* Update release: version 4.X.Y, based on v4.X.Y tag in the stable-4.X branch
  wrapped with updated packages


## Setup

Environment variables are specified in the files  `setvarminor`, `setvarmajor`
and `setvarupdate`. Most important are:

* Version numbers: `MAJORVERSION` and `MINORVERSION` are setting the major
  (i.e. the last number in GAP 4.4, 4.5, 4.6) and minor (i.e. the last number
  in GAP 4.4.12, 4.5.5, 4.5.17) version numbers. Each time after the appropriate
  public release is made, they have to be incremented as required.

* Paths: `MERGEDPKGLOC` specifies the location of the merged packages archive
  (assumed to be on the same machine) and `DISTROOT` specifies where to put the
  temporary directory tree and resulting archives. Currently these paths start
  with `/circa/home/gap-jenkins/workspace/` because this is the path used by Jenkins.
  Do not change them as this will break Jenkins jobs. The best way to test the
  release wrapping tools locally is to create the `/circa/home/gap-jenkins/workspace/`
  directory on your computer.


## Making release

There are three `make` targets to make corresponding releases:

* `make minor`, `make major`, `make update`: each of these targets copies
  one of the `setvarupdate`, `setvarminor` or `setvarmajor` to `setvar`
  script, and the calls the `doit` script which automates the full release
  wrapping procedure (see the description of `doit` and other scripts
  below)

* `make clean`: removes the `setvar` script to reset the release wrapping.
  (note that it does not remove the archives!)


## Description of scripts

The main `doit` script automates the full release wrapping procedure which
consists of three stages


### Stage 1: Checkout and archive the release branch

* `setvar`: set up environment variables as required (`make` with appropriate
  target will use one of `setvarupdate`, `setvarminor` or `setvarmajor` files).

* `checkoutgit`: makes a shallow clone of the appropriate branch of the repository.
  It records the revision and the time of cloning to use in the timestamp. From
  now on, the rest of the procedure is completely VCS-agnostic.

* `classifyfiles`: Uses `classifyfiles.py` script and specifications from
  `patternscolor` and `patternstextbinary.txt` to classify files into
  {text,binary} x {main_archive,tools} or not shipped (there is also a file
  `patternscolorpkg.txt` which is used to do the same for packages).

* `zipreleasebranch`: adds text and binary files to the archives of the core
  system and the tools archive.

* `zipmetainfo`: records what has been archived in the meta-information archive.


### Stage 2: make preparations in the GAP core

* `unpackreleasebranch`: unpacks the core system archive and the meta-information
  archive

* `updateversioninfo`: uses `sed` to insert version number, release date and
  other details into the source (so these adjustments will never appear in the
  repository; instead, after the release we will find the parent revision used
  to wrap the release and will tag it with an appropriate tag). See comment in
  `updateversioninfo` for further details.

* `fixpermissions`: sets `chmod 755` for directories and `chmod 644` for files.
  Also enforces some executables by calling `chmod 755`.

* `zipgapcore`: builds `gapmacrodoc.pdf`, then adds text and binary files to
  the archives of the core system and the tools archive.

* `updatemetainfo`: records what has been archived in the meta-information archive.


### Stage 3: merge GAP core with packages

* `unpackgapcore`: unpacks the core system archive and the meta-information
  archive

* `unpackpackages`: unpacks the merged archive of GAP packages to be
  redistributed with GAP, and classifies files into text/binary.

* `checkpermissions`: checks permissions for files in the `pkg` directory.

* `makedoc`: builds main GAP manuals (we have to do this now to resolve
  cross-references pointing to package manuals).

* `addmanualfiles`: adds manual files to the list of text and binary files
  to be wrapped.

* `zipgapsourcedistro`: wraps .zip, -win.zip, .tag.gz and .tar.bz2 archives
  for the GAP source distribution.

* `finalisemetainfo`: updates the meta-information archive.
