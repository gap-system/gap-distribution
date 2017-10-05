# Scrips for the package update mechanism

This directory contains a collection of script to check for new releases of
GAP packages and to wrap a merged archive of GAP packages accordingly to
certain specifications.


# Definitions

We distinguish "stable" and "latest" versions of packages. The "stable" is
the one which is included in the latest public GAP release. When the new
package release is picked up, this new version will be the "latest". If
it fails the tests, the fallback solution would be to use "stable".

After the new GAP release with the new version of the package will be
published, "latest" and "stable" versions will become the same, until
the next package release will be picked up.


# Setup

* Environment variables should be set in `setvarpkg`. Usually you need to
  do this only once while setting up the system.

* Currently paths specified there start  with `/circa/scratch/gap-jenkins/workspace/`
  because this is the path used by Jenkins. Do not change them as this will
  break Jenkins jobs. The best way to test the package update tools locally
  is to create the `/circa/scratch/gap-jenkins/workspace/` directory on your computer.

* package release repositories (i.e. repositories to store released versions
  of GAP packages; NOT their development repositories) are located in the
  `/circa/home/gap-jenkins/gap-packages-archive` directory on the Jenkins slave.
  If you clone them to use and test thDistributionUpdate/README.mde system locally, the best way to do
  it is to create the `/circa/scratch/gap-jenkins/workspace/` directory on your computer.


# Adding new package for the redistribution

The file `currentPackageInfoURLList` contains URLs of `PackageInfo.g` files.
It must be updated when a new package is added for redistribution or when
the URL of the `PackageInfo.g` file for some package is changed. Before making
changes, it is recommended to validate `PackageInfo.g` using the following form:
https://www.gap-system.org/Packages/validator.html. For further instructions,
see the comments in `currentPackageInfoURLList` file.

Remark: packages can migrate to new URLs without changes in the system. To do
this, it is sufficient to put the new `PackageInfo.g` file to the old location.


# Checking for package updates

* `./addPackages currentPackageInfoURLList`: adds new packages for the
  redistribution, checks that the stored URLs of `PackageInfo.g` coincide
  with the given ones, and enforces migration to the new `PackageInfo.g` URL
  when the `MOVE` option is used. See further comments in the GAP back-end
  for this operation which is `AddPackages` function in `PackageInfoTools.g`.

* `./updatePackageInfoFiles`: checks for updated `PackageInfo.g` files using
  `UpdatePackageInfoFiles` function from `PackageInfoTools.g`.

* `./updatePackageArchives`: fetches new archives, validates them and imports
  into the system in case the of the successful validation, using the function
  `updatePackageArchives` from from `PackageInfoTools.g`.


# Wrapping package archives

There are three `make` targets to make package archives: `make pkg-update`,
`make pkg-stable` and `make pkg-master`. Each of these targets can use
independent package specification, as recorded in the `Makefile`, for the
update, minor or major release respectively (see `DistributionUpdate/README.md`
for the definition of major, minor and update releases).

Usually each of these targets call `./mergePackages` and each of the three
archives are identical. However, there are situations when the new release
is only compatible with the master branch, or the new release breaks tests
and should be replaced by the stable version. For this purpose, one should
edit the `Makefile` to call `mergePackages` with additional arguments. The

`mergePackages` must be called in one of the following ways:

1. without arguments

2. with the word `all` to wrap individual package archives in all formats

3. with one of words `tip`, `latest` (synonym of `tip`) or `stable`

4. with specifications of the form `pkgname=tip|latest|stable|version|no`

5. with a combination of arguments as in (2) and (3) above

The GAP code for this is `MergePackages` function in `PackageInfoTools.g`.


# Evaluate packages after testing the release candidate and making the release   

* `markAllLatestStable` : to mark all latest versions of packages as stable
  if no problems were detected. This should be done when the release is published.

* if there are packages with latest releases breaking the test, one can not use
  `markAllLatestStable`. Instead, one should individuallyb specify stable
  versions using `markStableRevisions` called with a list of specifications
  of the form `pkgname=tip|latest|version`.

* `reportPackageVersions` reports latest and stable versions of all packages and
  may be used to check the settings. Internally, "latest" and "stable" are
  bookmarks in package release repositories (so you can use `hg bookmark`
  command if you need to correct them manually).

* After setting up "stable" versions to match the content of the public GAP
  release, use `markAllStableWithTimestamp` to tag stable versions of each
  package with the timestamp of the GAP distribution that includes them.
  Call is as e.g, `./markAllStableWithTimestamp gap4r5p4_2012_06_04-23_02`.


# Publishing GAP packages (to be used by the website maintainer)

* `updatePackageDocs`: update package manuals for the website

* `writePackageWebInfos`: generate Mixer code for packages section of the website

* `CopyToFtpServer`: copy package archives to the ftp server with (this script
  will perform a dry run first, so you will be able to check if the list is
  correct before copying).

* `CopyToWWW2`: copy manuals and autogenerated Mixer code to the place where
  they can be further processed and published (this script will also perform
  a dry run first, so you will be able to check if everything is right before
  copying).


# Other files

* `PackageInfoTools.g`: GAP back-end code for the package update mechanism.

* `reportPackageVersions`: script to report latest and stable versions of all
  packages currently redistributed with GAP. Its output is used to update
  https://github.com/gap-system/gap/wiki/Package-updates-status wiki page.

* `storeLegacyPackage`: was used to populate the package release repositories
  with the historical archives of package releases that were published before
  the current package update system was implemented.


# Legacy scrips - check if they can be removed:

* `addPackage` and `currentPackageInfoURLs` were used to set up the system, but
  apparently not in use any more as they were superseded by `addPackages` and
  `currentPackageInfoURLList`.

* `updateAllPackages`: not in use any more, since Jenkins has two separate jobs
  to checks for package updates and then to wrap new merged archive only in case
  there were any.
