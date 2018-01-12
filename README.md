# gap-distribution

## Core GAP system tests

| for branch | status | code coverage |
|------------|-------|---------------|
| `master` (core system test)  | [![Build Status](https://travis-ci.org/gap-system/gap.svg?branch=master)](https://travis-ci.org/gap-system/gap) |  [![Code Coverage](https://codecov.io/github/gap-system/gap/coverage.svg?branch=master&token=)](https://codecov.io/gh/gap-system/gap) |
| `master` (package integration test) | [![Build Status](https://travis-ci.org/gap-system/gap-docker-master-testsuite.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-master-testsuite) | |
| `stable-4.9` (package integration test) | [![Build Status](https://travis-ci.org/gap-system/gap-docker-stable-4.9-testsuite.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-stable-4.9-testsuite) | |

## Packages ready for the next releases
| for branch | status |
|-------|----|
| `master` | [![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master) |
| `stable-4.9` | [![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-4.9.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-4.9) |
| `stable-4.8` | [![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable) |

## Packages requiring inspection

| for branch | status |
|------------|--------|
| `master`   | [![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master-staging.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-master-staging) |
| `stable-4.9` | [![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-4.9-staging.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-4.9-staging) |
| `stable-4.8` | [![Build Status](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-staging.svg?branch=master)](https://travis-ci.org/gap-system/gap-docker-pkg-tests-stable-staging) |

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
