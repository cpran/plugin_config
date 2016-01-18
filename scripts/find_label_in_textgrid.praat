# Find label in a TextGrid Interval tier.
#
# The script runs through the intervals of an interval tier looking
# for a literal label. If found, it prints the number of the interval
# that holds it. Using the value in the "index" variable it's possible
# to look for the interval number with the nth repetition of the label.
#
# The first version of this script was written for the
# Laboratorio de Fonetica Letras UC
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
# Copyright 2011 - 2015 Jose Joaquin Atria

form Find label...
  integer    Tier 1
  sentence   Target
  optionmenu Direction: 1
    option   Forwards
    option   Backwards
  integer    Start_from 1
  comment    When searching backwards, starting point is counted from end
endform

include ../procedures/find_label.proc

if direction$ == "Forwards"
  @findLabelAhead(tier, target$, start_from)
  writeInfoLine: findLabelAhead.return
elsif direction$ == "Backwards"
  @findLabelBehind(tier, target$, start_from)
  writeInfoLine: findLabelBehind.return
else
  exitScript: "Error. Please contact author."
endif
