# gap-distribution

## Tests for the next major release

[![Build Status](https://travis-ci.org/gap-system/gap-docker-master-testsuite.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-master-testsuite) Package integration tests for the master branch (GAP standard test suite)

[![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master) GAP packages with standard tests passing in the GAP master branch

[![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master-staging.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master-staging) GAP packages with standard tests failing in the GAP stable branch

## Tests for the next minor release

[![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable) GAP packages with standard tests passing in the GAP master branch

[![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-staging.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-staging) GAP packages with standard tests failing in the GAP stable branch

---

This is the repository for various tools needed for GAP releases
(scripts for regression tests, release wrapping, managing package
updates, creating alternative distributions, etc.) and for some
developers' documentation.

It contains:

* `DistributionUpdate`: release wrapping scripts

* `DistributionUpdate/PackageUpdate`: scrips for the package update mechanism

* `testing`: files used by various Jenkins tests

* `winist`: files needed to build GAP Installer for Windows

Further details are contained in `README.md` files in corresponding directories.
