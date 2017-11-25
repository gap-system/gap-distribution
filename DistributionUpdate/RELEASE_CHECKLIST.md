# Preparations for the release


## Is now a good time for a release?

* We aim at making a minor release every several months and a major release once or twice per year. 

* Actual schedule may be corrected - critical bug fixes may need an urgent minor release, and substantial changes may require more time for a major release. 

* Usually, if a previous minor release has been made a couple of months ago, and there is a substantial amount (say, 15 or more) of updated packages and/or changes in the core GAP system, there may be a time for a release.


## Are regression tests of the release branch in a good state?

Evaluate weekly and nightly Jenkins CI tests (the following links are accessible only within University of St Andrews network).

* For the minor release: https://gap-ci.cs.st-andrews.ac.uk/job/GAP-minor-release/ and its downstream projects

* For the major release: https://gap-ci.cs.st-andrews.ac.uk/job/GAP-major-release/ and its downstream projects

Minimal requirements for the test suite to pass:

* no diffs in `testinstall` and `teststandard` with and without packages (checked automatically)
* no diffs in `testmanuals` with default packages loaded (checked automatically) and no break loops or crashes in other two variants of the test (checked manually)
* no errors and warnings when GAP is loaded (checked manually)
* `testpackagesload` should be able to load all packages in all 4 configurations (checked automatically)
* most of the packages should be loadable in `testpackagesload` test (checked manually using the summary at the end of the test log file; requires action in case of essential regressions)
* no critical regressions in package tests in `testpackages` (checked manually using the summary at the end of the test log file (which then can be copied to https://github.com/gap-system/gap/wiki/Status-of-standard-tests-in-GAP-packages); requires action in case of essential regressions)


## Is there anything else to be released?

* Are there any outstanding issues and/or pull requests under the GitHub milestone for the coming release (see https://github.com/gap-system/gap/milestones)? Should they be resolved/merged or left for another release?

* Are there any issues with updated packages that should be resolved either by picking up their next updates? In case package updates are delayed, but it is necessary to proceed with the release, follow instructions at https://github.com/gap-system/gap-distribution/tree/master/DistributionUpdate/PackageUpdate to use their previous releases.


## What should be highlighted in the overview of changes in this release?

* Add an overview of the coming release to the Changes manual, either as a new section for a minor release or a new chapter for a major release.

* For a minor release, use appropriate milestone at https://github.com/gap-system/gap/milestones, but also check the release branch for any obvious omissions.

* For a major release, use appropriate milestone at https://github.com/gap-system/gap/milestones, and also check https://github.com/gap-system/gap/wiki/Changes-between-GAP-4.8-and-GAP-4.9 (or another similarly named page) which may be a better place to work on a draft of a high level overview of changes and new features in a major release.

# Evaluating release candidate

## Evaluate weekly and nightly tests

Evaluate weekly and nightly Jenkins CI tests (the following links are accessible only within University of St Andrews network).

* For the minor release: https://gap-ci.cs.st-andrews.ac.uk/job/GAP-minor-release/ and its downstream projects

* For the major release: https://gap-ci.cs.st-andrews.ac.uk/job/GAP-major-release/ and its downstream projects

Minimal requirements for the test suite to pass are the same as described above.

## Download release candidate and install yourself

* For Linux and macOS, use `tar.bz2`, `tar.gz` or `zip` archives:

  - For the minor release from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-minor-release/ 
 
  - For the major release from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-major-release/

* Install the core system and build packages with `bin/BuildPackages.sh`

* Run some tests from the GAP test suite (at least call `make testinstall`, which does take much time).

* Start GAP and try some features of the user interface which are not observable in batch computations:
  - `Tab` completion
  - scrolling command line history with arrow keys
  - using colour prompt with `ColorPrompt(true)`
  - check that the readline functionality works (e.g. entering multiline commands, using `Ctrl-_` for undoing)
  - using the help system with `?` and `??` commands
  - using Browse package, e.g. for help selection or in `Browse(CharacterTable("M11"))`
  - Using browser as a help viewer, e.g. with `SetHelpViewer("firefox")` on Linux and `SetHelpViewer("safari")` on Mac.
 
* Try `LoadAllPackages()` and check that it does not go into a break loop (you may need to load GAP with `-r` option to avoid interfering with locally installed packages in your `.gap` directory).

## Additional checks for Windows:

For Windows, use `win.zip` archives.

* For the minor release:
  - 32-bit from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-major-release-win-build/
  - 32-bit without readline support from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-minor-release-win-noreadline-build/
  - 64-bit from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-minor-release-win-build64/

* For a major release:
  - 32-bit from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-major-release-win-build/
  - other builds will be added soon

For a major release, one should perform these checks for each of the batch files `gap.bat`, `gapcmd.bat` and `gaprxvt.bat`, and also check the version built without readline support and experimental 64-bit version. For a minor release, one could perform more thorough checks with `gap.bat` and just check that the two other files also start GAP.

* All mentioned above features of the user interface which are not observable in batch computations
* run `testinstall.g` (optionally `teststandard.g` as well)
* check that copying and pasting works
* check that `WriteGapIniFile()` successfully writes `gap.ini` file
* check that it is possible to set up user preferences in `gap.ini` file (e.g. `UseColorPrompt`)
* check the value of `GAPInfo.UserGapRoot`
* is Windows properly recognized, that is `ARCH_IS_WINDOWS();` must return `true`
* does `TmpNameAllArchs()` produce a valid tmp file name?
* does `DirectoryTemporary()' create a valid tmp directory? (On Windows, it might be not deleted properly when GAP exits, and should be cleaned up by other means)
* Does `DirectoryHome()' and `DirectoryDesktop()' return the proper folders? (This has languages hard coded)
* Does `Exec` work? For example, try `Exec("dir")`.
* run memory-demanding test and check that the memory GAP occupies grows up to a reasonable size
* test that the help system works '''twice''': with and without Browse package
  - with Pager
  - with SetHelpViewer("browser");

Additionally:
* check that packages with compiled kernel modules work (Browse, cvec, edim, io, orb) 
* check that text files are converted to have appropriate line endings;
* test MathJax support in HTML manuals;


## Prepare and test Windows installer

* See instructions in https://github.com/gap-system/gap-distribution/tree/master/wininst

# Publishing release

## Prepare all data

### Collect main distribution archives

The following files should be collected:
* full distributions in `tar.bz2`, `tar.gz` and `zip` archives for Linux and macOS
* full distributions in `-win.zip`, `-noreadline-win.zip` and `-win64.zip` archives for Windows
* GAP installer for Windows (`.exe` file)
* core GAP system archive named in `gap-4.X.Y-core.zip` format in the `www.gap-system.org/pub/gap/gap4core` directory (for GAP developers and for maintainers of alternative GAP distributions)

* `tar.bz2`, `tar.gz` and `zip` archives:
  - For the minor release from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-minor-release/ 
  - For the major release from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-major-release/

*  `-win.zip` archives for a minor release:
  - 32-bit from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-major-release-win-build/
  - 32-bit without readline support from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-minor-release-win-noreadline-build/
  - 64-bit from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-minor-release-win-build64/

*  `-win.zip` archives for a major release:
  - 32-bit from https://gap-ci.cs.st-andrews.ac.uk/view/GAP-release/job/GAP-major-release-win-build/
  - other builds will be added soon

### Prepare package archives



### Prepare website updates

We suggest to make each of the steps below in a separate commit to https://github.com/gap-system/GapWWW, and check in the revisions history how theses steps were implemented for previous releases:

* Commit autogenerated files for packages in the new distribution in the [`Packages` directory](https://github.com/gap-system/GapWWW/tree/master/Packages)

* Prepare new data for links in all manuals: in the `dev` directory of the main GAP repository, call `gap -r -A LinksOfAllHelpSections.g` and then move the produced `AllLinksOfAllHelpSections.data` file into the `lib` directory of the GAP website repository

* Update config parameters in the [`lib/config` file](https://github.com/gap-system/GapWWW/blob/master/lib/config)

* Update GAP banner in [`Download/index.mixer`](https://github.com/gap-system/GapWWW/blob/master/Download/index.mixer)

* Update packages overview page and left navigation bar (determined by `Packages/tree` file): check for new and renamed packages, packages that were accepted as a result of their refereeing, etc.

* Prepare downloads page for the new release, update left navigation bar (determined by `Releases/tree` file) and `Releases/index.html` symbolic link. To create new downloads page, you can use the page for the previous release as a template. For the overview of packages included in the GAP distribution, use `Packages/pkgstaticlist` file.

## Publish all data

To be able to publish all archives, up-to-date documentation and new version of the website, you need to know how to access the host server.

### Publish main distribution archives

Assuming you've copied all main distribution archives into some new directory (say, `~/distro`) in the pseudo-user's account on the host server, you can perform the following commands in that directory to move them to their final locations (adjust file names with release numbers and timestamps as needed):

```
mv *.exe ../www.gap-system.org/pub/gap/gap48/exe/
mv *.tar.bz2 ../www.gap-system.org/pub/gap/gap48/tar.bz2/
mv *.tar.gz ../www.gap-system.org/pub/gap/gap48/tar.gz/
mv *-win.zip ../www.gap-system.org/pub/gap/gap48/win.zip/
mv *-win64.zip ../www.gap-system.org/pub/gap/gap48/win.zip/
mv gap-4.X.Y-core.zip ../www.gap-system.org/pub/gap/gap4core/
mv *.zip ../www.gap-system.org/pub/gap/gap48/zip/
```

Check that everything (locations, permissions etc.) look right with
```
ls -la ../www.gap-system.org/pub/gap/gap48/*/gap-4.X.Y* 
```

### Publish package archives

* **Publish merged package archives and "bootstrapping" archives** (i.e. archives of GAP packages downloaded by `make bootstrap-pkg-minimal` and `make bootstrap-pkg-full`) at `www.gap-system.org/pub/gap/gap4pkgs/` (for GAP developers and for maintainers of alternative GAP distributions). 

Archives in this directory contain selections of all packages that were released with corresponding releases (marked with corresponding tags e.g. `v4.7.8`) and that would be released with the next minor/major release (marked with the name of the release branch, i.e. `stable-4.8` and `master`).

For example, if the merged archive of GAP packages is `~/distro/packages-2017_03_23-22_46_UTC.tar.gz` in the pseudo-user's account on the host server, the following commands will update bootstrapping archives (adjust file names with release numbers and timestamps as needed).

First, move the archive to the required directory and rename it accordingly to the version number of the GAP release to which it belongs:
```
mv packages-2017_03_23-22_46_UTC.tar.gz ../www.gap-system.org/pub/gap/gap4pkgs/packages-v4.8.X.tar.gz
```
Now change to that directory and copy it to archives used with tips of the stable and master branches
```
cd ../www.gap-system.org/pub/gap/gap4pkgs/
cp packages-v4.8.X.tar.gz packages-master.tar.gz
cp packages-v4.8.X.tar.gz packages-stable-4.8.tar.gz
```
Here we assume that there are no disruptive changes and the latest versions of released packages can be used with tips of the stable and master branches. If this will not be the case, we may need to prepare different versions of `packages-master.tar.gz` and `packages-stable-4.8.tar.gz` archives.

Finally, update the symbolic link for `bootstrap-pkg-full.tar.gz`:
```
rm bootstrap-pkg-full.tar.gz 
ln -s packages-v4.8.X.tar.gz bootstrap-pkg-full.tar.gz
```

You may also need to update the archive of the required packages. It currently contains only GAPDoc package. If there was no new release of GAPDoc, it is sufficient to duplicate the archive, incrementing the version number:
```
cp packages-required-stable-v4.8.N.tar.gz packages-required-stable-v4.8.N+1.tar.gz 
```
Otherwise, you need to produce new `packages-required-stable-v4.8.X.tar.gz` (as long as we have only one required package, just renaming the GAPDoc package archive suffices). Then call:
```
cp packages-required-stable-v4.8.X.tar.gz packages-required-stable-4.8.tar.gz
cp packages-required-stable-4.8.tar.gz packages-required-master.tar.gz
```
and then update the symbolic link
```
rm bootstrap-pkg-minimal.tar.gz 
ln -s packages-required-stable-v4.8.X.tar.gz bootstrap-pkg-minimal.tar.gz
```
Finally, check with `ls -la` that everything looks fine (consistent file sizes, permissions, symbolic links, etc.)

* **Publish individual package archives**

### Publish manuals of GAP and packages

* The `doc` Main GAP manuals should be copied to `www.gap-system.org/Manuals/doc` (so that the links will have the form http://www.gap-system.org/Manuals/doc/ref/chap0.html etc.)

* Package manuals should be copied to  `www.gap-system.org/Manuals/pkg/...` (so that the links will have the form http://www.gap-system.org/Manuals/pkg/GAPDoc-1.6/doc/chap0.html etc.)

* For the GAP Docker container: on the host server, navigate to `www.gap-system.org/Manuals` and then call (adjusting version number as appropriate):
```
tar -cvzf gap-4.X.Y-manuals.tar.gz doc/
mv gap-4.X.Y-manuals.tar.gz doc/
```
This archive will be available under `www.gap-system.org/Manuals/doc/gap-4.X.Y-manuals.tar.gz` and will be retrieved and placed into the GAP Docker container.

### Make updated website live

* Login into the host server, change to the directory `www.gap-system.org` which contains the clone 
of the [GAP website repository](https://github.com/gap-system/GapWWW) and run
```
git pull
../Mixer/mixer.py -f
```
to regenerate updated pages.

## Announce the release

* In the [GAP Forum](http://mail.gap-system.org/mailman/listinfo/forum) (see an example [here](http://mail.gap-system.org/pipermail/forum/2017/005468.html)) 

* On Twitter as [@gap_system](https://twitter.com/gap_system)

## Post-release actions

* tag corresponding revision in appropriate release branch in the git repository for the core GAP system with the tag in the format `v4.X.Y`

* Create a new milestone for the next release (if not yet created) at https://github.com/gap-system/gap/milestones

* Increment version numbers in `setvarminor`, `setvarupdate` (and `setvarmajor`, if needed) files in https://github.com/gap-system/gap-distribution/tree/master/DistributionUpdate to specify version numbers for next minor/major releases (see an example in [this commit](https://github.com/gap-system/gap-distribution/commit/907c323a537857799ebda4743cd65587aecb12ac)).

* In case there are any entries in the [`dev/Updates` directory](https://github.com/gap-system/gap/tree/master/dev/Updates) in the relevant release branch, they should be moved to to another folder named accordingly to the released version.

* Maintainers of alternative installers/distributions may now update them:

  - Homebrew: https://github.com/Homebrew/homebrew-science/blob/master/gap.rb 

  - Docker: https://hub.docker.com/u/gapsystem/  
 
