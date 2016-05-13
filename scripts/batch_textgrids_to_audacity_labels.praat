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
# Copyright 2013-2016 Jose Joaquin Atria

include ../../plugin_utils/procedures/check_directory.proc
include ../../plugin_utils/procedures/require.proc
@require("5.3.44")

#! ~~~params
#! in:
#!   TextGrid_directory: >
#!     (word) The directory with TextGrid files to process
#!   Tier: >
#!     (integer) The tier to convert
#!   Print_to_Info: >
#!     (boolean) If true, the labels will be printed to the Info window
#!     (or STDOUT). Otherwise, they'll be saved to the same directory.
#! ~~~
#!
#! Converts all TextGrid objects in the specified directory
#! to Audacity labels and either saves them to external files
#! or prints them to the Info window.
#!
form TextGrids in directory to Audacity labels...
  comment Leave blank for GUI selector
  word TextGrid_directory
  integer Tier 1
  boolean Print_to_Info no
endform

@checkDirectory(textGrid_directory$, "Choose TextGrid directory...")
path$ = checkDirectory.name$

files = Create Strings as file list: "files", path$ + "*TextGrid"

n = Get number of strings
for i to n
  selectObject(files)
  filename$ = Get string: i
  textgrid = Read from file: path$ + filename$
  runScript: "textgrid_to_audacity_label.praat", tier, path$, print_to_Info
  removeObject(textgrid)
endfor
removeObject(files)
