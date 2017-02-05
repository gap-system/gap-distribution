# Scripts used by Jenkins

This is the directory to put various scripts that may be needed by Jenkins
jobs and should be located outside Jenkins in order to keep them under version
control. Usually they are retrieved from GitHub using `wget` from appropriate
Jenkins jobs. Sometimes these scripts may differ dependently on whether they
are used for the update, minor or major release. Such scripts should be placed
in the directories named `update`, `stable` or `master` respectively.
