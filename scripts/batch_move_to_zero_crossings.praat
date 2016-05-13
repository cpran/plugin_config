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
# Copyright 2012 - 2015 Jose Joaquin Atria

include ../../plugin_utils/procedures/require.proc
include ../../plugin_utils/procedures/check_directory.proc

#! ~~~ params
#! in:
#!   Sound_directory: >
#!     (sentence) Path of directory with sound files
#!   TextGrid_directory: >
#!     (sentence) Path of directory with TextGrid files
#!   Output_directory: >
#!     (sentence) Path of directory where modified TextGrids will be saved
#!   Tier: >
#!     (integer) Tier to process in each file (`0` means "process all")
#!   Maximum_shift: >
#!     (integer) The maximum allowed time shift (`0` means "no maximum")
#!   Ignore_points: >
#!     (boolean) If true, point tiers will be ignored
#! ~~~
#!
#! Move the boundaries in all TextGrid files in a directory to the
#! nearest zero-crossing in an accompanying sound file.
#!
#! See the documentation of the `Move to zero-crossings...` command to
#! read a more detailed description.
#!
form Move boundaries to zero-crossings (batch)...
  sentence Sound_directory
  sentence TextGrid_directory
  sentence Output_directory
  integer Tier 0 (= all)
  integer Maximum_shift_(s) 0 (= no maximum)
  boolean Ignore_points 1
endform

if !fileReadable(preferencesDirectory$ + "/plugin_vieweach")
  exitScript: "This script requires the vieweach plugin to run"
endif

strutils$ = preferencesDirectory$ + "/plugin_strutils/scripts/"
tgutils$  = preferencesDirectory$ + "/plugin_tgutils/scripts/"

# The current version of this script uses the new syntax, made available
# with Praat v.5.3.44
@require("5.3.44")

@checkDirectory(sound_directory$, "Read Sounds from...")
sound_directory$ = checkDirectory.name$

# Make a list of Sounds to process
runScript: strutils$ + "file_list_full_path.praat",
  ... "sounds", sound_directory$, "*.wav", "no"
sounds = selected("Strings")
total_sounds = Get number of strings

@checkDirectory(textGrid_directory$, "Read TextGrids from...")
textgrid_directory$ = checkDirectory.name$

# Make a list of Sounds to process
runScript: strutils$ + "file_list_full_path.praat",
  ... "textgrids", textgrid_directory$, "*.TextGrid", "no"
textgrids = selected("Strings")
total_textgrids = Get number of strings

@checkDirectory(output_directory$, "Save TextGrids to...")
output_directory$ = checkDirectory.name$

script$ = tgutils$ + "move_to_zero_crossings.praat"
call batch
  ... runScript: "'script$'", 'tier', 'maximum_shift', 'ignore_points' \n
  ... selectObject: selected("TextGrid")                               \n
  ... name$ = selected$("TextGrid")                                    \n
  ... out$ = "'output_directory$'" + name$ + "_zero.TextGrid"          \n
  ... Save as text file: out$                                          \n

# Execute the script
selectObject: sounds, textgrids
runScript: preferencesDirectory$ + "/plugin_vieweach/scripts/" +
  ... "for_each.praat", batch.script$, "Use sets"

# Clean up
deleteFile: batch.script$
removeObject: sounds, textgrids

procedure batch: .src$
  # Generate a temporary script with the needed parameters
  @mktempfile: "batch_zero_crossings.XXXXXX", ".praat"
  .script$ = mktempfile.name$

  # For convenience, replace instances of \n with a newline
  .src$ = replace_regex$(.src$, "\s+\\n\s?", newline$, 0)

  writeFileLine: .script$, .src$
endproc
