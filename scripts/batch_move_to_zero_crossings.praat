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

include ../../plugin_utils/procedures/require.proc
include ../../plugin_utils/procedures/check_directory.proc

# The current version of this script uses the new syntax, made available
# with Praat v.5.3.44
@require("5.3.44")

@checkDirectory(sound_directory$, "Read Sounds from...")
sound_directory$ = checkDirectory.name$

@checkDirectory(textGrid_directory$, "Read TextGrids from...")
textgrid_directory$ = checkDirectory.name$

@checkDirectory(output_directory$, "Save TextGrids to...")
output_directory$ = checkDirectory.name$

verbose = 0

cleared = 0
if verbose
  clearinfo
  cleared = 1
endif

sounds = Create Strings as file list: "files",
  ... sound_directory$ + "*wav"
total_sounds = Get number of strings

textgrids = Create Strings as file list: "files",
  ... textgrid_directory$ + "*TextGrid"
total_textgrids = Get number of strings

# Perform initial checks on available objects
if !total_sounds or total_sounds and (total_sounds != total_textgrids)
  exitScript: "Not able to read an equal number of Sound and TextGrid objects."
endif

for current to total_sounds

  selectObject: sounds
  sound_file$ = Get string: current
  sound = Read from file: sound_directory$ + sound_file$

  selectObject: textgrids
  textgrid_file$ = Get string: current
  textgrid = Read from file: textgrid_directory$ + textgrid_file$

  selectObject: sound, textgrid
  runScript: "../textgrid/move_to_zero_crossings.praat",
    ... tier, maximum_shift, ignore_points

  selectObject: textgrid
  name$ = selected$("TextGrid")
  Save as text file: output_directory$ + name$ + "_zero" + "TextGrid"

  removeObject: sound, textgrid

endfor

removeObject: sounds, textgrids
