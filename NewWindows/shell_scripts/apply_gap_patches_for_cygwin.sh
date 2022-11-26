#!/usr/bin/env bash
cd /opt/gap

# This applies some small fixes to GAP

# Remove ExternalFilename from Packages
(cd pkg && find anupq-* grape-* -type f -print0 | xargs -0 sed -i '' -e 's/ExternalFilename/Filename/')

# Fix semigroups
(cd pkg && find semigroups-* -type f -print0 | xargs -0 sed -i '' -e 's/cygsemigroups-0.dll/cygsemigroups-1.dll/' )