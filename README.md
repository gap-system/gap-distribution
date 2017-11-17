# gap-distribution

## Core GAP system tests

[![Build Status](https://travis-ci.org/gap-system/gap.svg?branch=master)](https://travis-ci.org/gap-system/gap) [![Code Coverage](https://codecov.io/github/gap-system/gap/coverage.svg?branch=master&token=)](https://codecov.io/gh/gap-system/gap) GAP master branch tests

[![Build Status](https://travis-ci.org/gap-system/gap-docker-master-testsuite.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-master-testsuite) Package integration tests for the master branch

## Packages ready for the next releases

[![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master) for major release

[![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable) for minor release

## Packages requiring inspection

[![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master-staging.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master-staging) for major release

[![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-staging.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-staging) for minor release

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
