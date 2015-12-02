# Detect non-overlapping intervals in a multi-tiered TextGrid
#
# This script will generate a new TextGrid object with a single tier
# containing intervals obtained by "flattening" those of all tiers in the
# original TextGrid.
#
# Depending on the label of those intervals, it will be possible to determine
# whether they were silent in the original (no label), whether they have an
# overlap across tiers ("0" as the label), or whether they are a non-overlapping
# interval, in which case the number of the tier to which they correspond will
# be the label.
#
# Based on https://uk.groups.yahoo.com/neo/groups/praat-users/conversations/messages/6947
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

include ../procedures/to_non-overlapping_intervals.proc

textgrids = numberOfSelected("TextGrid")
for i to textgrids
  tg[i] = selected("TextGrid", i)
endfor

for i to textgrids
  selectObject: tg[i]
  @toNonOverlappingIntervals()
  newtg[i] = selected("TextGrid")
endfor

nocheck selectObject: undefined
for i to textgrids
  plusObject: newtg[i]
endfor
