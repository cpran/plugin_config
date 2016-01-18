# Equalise TextGrid tier durations (batch)
#
# Praat allows for tiers of different durations to be merged
# into a single annotation file. However, this is contrary to
# the expectations of most scripts in existence. Since it is
# also hard to check whether a given TextGrid will suffer from
# this, this script extends all tiers of insufficient length
# until they reach the duration of the longest.
#
# This script is part of the tgutils CPrAN plugin for Praat.
# The latest version is available through CPrAN or at
# <http://cpran.net/plugins/tgutils>
#
# The tgutils plugin is free software: you can redistribute it
# and/or modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation, either
# version 3 of the License, or (at your option) any later version.
#
# The tgutils plugin is distributed in the hope that it will be
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with tgutils. If not, see <http://www.gnu.org/licenses/>.
#
# Copyright 2014, 2015 Jose Joaquin Atria

form Equalize tier durations...
  sentence Read_from
  sentence Save_to
  comment Leave paths empty for GUI selector
endform

include ../../plugin_utils/procedures/utils.proc
include ../../plugin_utils/procedures/check_directory.proc
include ../procedures/make_tier_times_equal.proc

if !fileReadable(preferencesDirectory$ + "/plugin_vieweach")
  exitScript: "This script requires the vieweach plugin to run"
endif

@checkDirectory(read_from$, "Read TextGrids from...")
read_from$ = checkDirectory.name$

@checkDirectory(save_to$, "Save TextGrids to...")
save_to$ = checkDirectory.name$

# Make a list of TextGrids to process
runScript: preferencesDirectory$ + "/plugin_strutils/scripts/" +
  ... "file_list_full_path.praat",
  ... "files", read_from$, "*.TextGrid", "no"
filelist = selected("Strings")
files = Get number of strings

# Generate a temporary script with the needed parameters
@mktempfile: "batch_equal_tiers_XXXXXX", ".praat"
tmp$ = mktempfile.name$
writeFileLine:  tmp$, ""
appendFileLine: tmp$,
  ... "runScript: preferencesDirectory$ + ""/plugin_tgutils/scripts/" +
  ...   "make_tier_times_equal.praat"""
# Since this is a batch script, save and remove the generated
# objects as soon as the execution for each original TextGrid
# is complete
appendFileLine: tmp$,
  ... "Save as text file: """,
  ... save_to$, """ + selected$(""TextGrid"") + "".TextGrid"""
appendFileLine: tmp$, "Remove"

# Execute the script
runScript: preferencesDirectory$ + "/plugin_vieweach/scripts/" +
  ... "for_each.praat", tmp$, "Use sets"

# Clean up
deleteFile: tmp$
removeObject: filelist
