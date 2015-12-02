# Equalise TextGrid tier durations (batch)
#
# Praat allows for tiers of different durations to be merged into a single
# annotation file. However, this is contrary to the expectations of most
# scripts in existence. Since it is also hard to check whether a given TextGrid
# will suffer from this, this script extends all tiers of insufficient length
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
  boolean Verbose no
endform

include ../procedures/make_tier_times_equal.proc
include ../procedures/check_directory.proc

@checkDirectory("Read TextGrids from...", read_from$)
read_from$ = checkDirectory.name$

@checkDirectory("Save TextGrids to...", save_to$)
save_to$ = checkDirectory.name$

filelist = Create Strings as file list: "files", read_from$ + "*.TextGrid"
files = Get number of strings

for f to files
  selectObject: filelist
  filename$ = Get string: f
  textgrid = Read from file: read_from$ + filename$

  @makeTierTimesEqual()
  selectObject: makeTierTimesEqual.id

  Save as text file: save_to$ + textgrid$ + ".TextGrid"
  # End file loop
endfor
