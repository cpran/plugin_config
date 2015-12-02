# Equalise TextGrid tier durations
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

include ../procedures/make_tier_times_equal.proc

textgrids = numberOfSelected("TextGrid")

if !textgrids
  exitScript: "No TextGrid objects selected"
endif

for i to textgrids
  tg[i] = selected("TextGrid", i)
endfor

for i to textgrids
  selectObject: tg[i]
  name$ = selected$("TextGrid")
  @makeTierTimesEqual()
  current = selected()
  if tg[i] = current
    new[i] = Copy: name$ + "_unchanged"
  else
    new[i] = selected()
  endif
endfor

nocheck selectObject: undefined
for i to textgrids
  plusObject: new[i]
endfor
