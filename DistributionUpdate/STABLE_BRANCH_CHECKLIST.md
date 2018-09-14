# Switching to a new stable branch

This is the checklist for actions needed to set up continuous integration in
preparation for the next major release of GAP, version X.Y.

* Create stable branch named `stable-X.Y` for corresponding X and Y.

* Create a pair of labels for GitHub issues called `backport-to-X.Y` and 
`backport-to-X.Y-DONE`.

* Create a GitHub milestone for GAP X.Y.0 release. 

* Inform GAP developers via the mailing list about the creation of the new
branch. Remind that from now on any new pull requests that needs to added
to `stable-X.Y` should be given the label `backport-to-X.Y`.

* Prepare merged package archives in the https://www.gap-system.org/pub/gap/gap4pkgs
directory (adjust X,Y as needed):
```
cp packages-master.tar.gz packages-stable-X.Y.tar.gz
cp packages-required-master.tar.gz packages-required-stable-X.Y.tar.gz
```

* In the stable-X.Y branch, change `PKG_BRANCH` from `master` to `stable-X.Y` 
in order to point to bootstrapping package archives for the stable-X.Y branch.

* Update badges for the core system tests at
https://github.com/gap-system/gap-distribution/blob/master/README.md

* Update version numbers in the master branch of `setvarminor` and `setvarmajor`
files in https://github.com/gap-system/gap-distribution/tree/master/DistributionUpdate/.
This repository may have a branch `stable-X.{Y-1}`, but it is not necessary to
create `stable-X.Y` there immediately - we will create a branch only if the need
will arise later.

* Update https://github.com/gap-system/gap-distribution/blob/master/DistributionUpdate/PackageUpdate/Makefile
to use package specification for master branch for stable-X.Y branch.

* Update https://gap-ci.cs.st-andrews.ac.uk/view/GAP-pkg/job/GAP-pkg-merge-stable/
to build from the master branch of the gap-distribution repository (if need be,
we will switch it to build from `stable-X.Y` later).

* Update https://gap-ci.cs.st-andrews.ac.uk/view/GAP-pkg/job/GAP-pkg-update-stable-snapshot/
to use `stable-X.Y` branch of the GAP repository

* Update https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-minor-release/
to build from the master branch of the gap-distribution repository (if need be,
we will switch it to build from `stable-X.Y` later).

* Create new repository gap-system/gap-docker-stable-X.Y by importing
https://github.com/gap-system/gap-docker-pkg-tests-master (to preserve the 
history) and set up builds for the Docker container 
gapsystem/gap-docker-stable-X.Y at https://hub.docker.com/u/gapsystem/

* Create new repository gap-system/gap-docker-stable-X.Y-testsuite by importing
https://github.com/gap-system/gap-docker-master-testsuite (to preserve the history)
and set up Travis builds for this repository to run package integration tests.

* Similarly, set up the following repositories and travis builds to run standard tests for GAP packages:
  - gap-system/gap-docker-pkg-tests-stable-4.X from https://github.com/gap-system/gap-docker-pkg-tests-master
  - gap-system/gap-docker-pkg-tests-stable-4.X-staging from https://github.com/gap-system/gap-docker-pkg-tests-master-staging 
  - gap-packages/gap-docker-pkg-tests-stable-4.X-devel from https://github.com/gap-packages/gap-docker-pkg-tests-master-devel

* Add badges for corresponding Travis CI builds to
https://github.com/gap-system/gap-distribution/blob/master/README.md

* Adjust settings for newly created Travis builds: limit concurrent jobs to 1;
cron jobs to run daily for the master branch; do not run if there has been a
build in the last 24 hours

* Adjust settings for Travis builds for stable-X.{Y-1} branch: decide to run
them weekly or monthly, and eventually retire them by disabling builds and
archiving repositories.

* In Jenkins, disable the job `gap-docker-stable-X.{Y-1}-trigger` which triggers
the nightly builds of the Docker container for stable-X.{Y-1} branch, and setup
a job `gap-docker-stable-X.Y-trigger` to trigger nightly builds of the Docker
container for the stable-X.Y branch (use "Trigger your Automated Build by
sending a POST to a specific endpoint" in Build settings on DockerHub to
generate the URL and use it in the shell script in Jenkins in the form 
```
curl -H "Content-Type: application/json" --data '{"build": true}' -X POST https://registry.hub.docker.com/u/gapsystem/gap-docker-stable-X.Y/trigger/token/
```
