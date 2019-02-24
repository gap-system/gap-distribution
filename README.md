# gap-distribution

## Core GAP system tests

| for branch | status | code coverage |
|------------|--------|---------------|
| `master`   | [![Build Status](https://travis-ci.org/gap-system/gap.svg?branch=master)](https://travis-ci.org/gap-system/gap) | [![Code Coverage](https://codecov.io/github/gap-system/gap/coverage.svg?branch=master&token=)](https://codecov.io/gh/gap-system/gap) |
| `stable-4.10` | [![Build Status](https://travis-ci.org/gap-system/gap.svg?branch=stable-4.10)](https://travis-ci.org/gap-system/gap) | [![Code Coverage](https://codecov.io/github/gap-system/gap/coverage.svg?branch=stable-4.10&token=)](https://codecov.io/gh/gap-system/gap) |
| `stable-4.9`  | [![Build Status](https://travis-ci.org/gap-system/gap.svg?branch=stable-4.9)](https://travis-ci.org/gap-system/gap) | [![Code Coverage](https://codecov.io/github/gap-system/gap/coverage.svg?branch=stable-4.9&token=)](https://codecov.io/gh/gap-system/gap) |

## Package integration tests

| for branch | status |
|------------|--------|
| `master`  | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-master-testsuite.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-master-testsuite) |
| `stable-4.10` | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-stable-4.10-testsuite.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-stable-4.10-testsuite) |
| `stable-4.9` | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-stable-4.9-testsuite.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-stable-4.9-testsuite) |

## Tests of approved official package releases for their readiness for the next GAP release

Status of standard tests for packages updates that were picked up, passed internal testing, and were included into the corresponding archive.

| for branch | packages archive | ready for the next GAP release | require inspection |
|------------|-----------------------------------|---------------|---------------------|
| `master` | [packages-master.tar.gz](https://www.gap-system.org/pub/gap/gap4pkgs/packages-master.tar.gz) | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-master.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-master) | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-master-staging.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-master-staging) |
| `stable-4.10` | [packages-stable-4.10.tar.gz](https://www.gap-system.org/pub/gap/gap4pkgs/packages-stable-4.10.tar.gz) | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.10.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.10) | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.10-staging.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.10-staging) |
| `stable-4.9` | [packages-stable-4.9.tar.gz](https://www.gap-system.org/pub/gap/gap4pkgs/packages-stable-4.9.tar.gz) | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.9.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.9) | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.9-staging.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.9-staging) |

## Tests of package development versions for their compatibility with the GAP development version

Status of standard tests for [development versions of GAP packages having a public repository on GitHub](https://gap-packages.github.io/). 

| for branch | Click on the badge to see the status for each package |
|------------|-------------------------------------------------------|
| `master` | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-master-devel.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-master-devel) |
| `stable-4.10` | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.10-devel.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.10-devel) |
| `stable-4.9` | [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.9-devel.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests-stable-4.9-devel) |

## Further links:
* Status of standard tests of GAP packages from the latest public release of GAP: [![Build Status](https://travis-ci.org/gap-infra/gap-docker-pkg-tests.svg?branch=master)](https://travis-ci.org/gap-infra/gap-docker-pkg-tests)
* [Travis CI builds of GAP packages](https://travis-ci.org/gap-packages/)
* [AppVeyor builds for the core GAP system](https://ci.appveyor.com/project/gap-system/gap)
* [Code coverage for GAP packages](https://codecov.io/gh/gap-packages/)
* [GAP Docker containers on Docker Hub](https://hub.docker.com/r/gapsystem/)

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
