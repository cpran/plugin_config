# Separate a TextGrid into interval-sized parts
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

form Explode TextGrid...
  integer Tier 1
  boolean Preserve_times 0
endform

sound = numberOfSelected("Sound")
if sound
  sound = selected("Sound")
endif
textgrid = selected("TextGrid")

selectObject: textgrid
interval = Is interval tier: tier
if !interval
  exit Not an interval tier
endif

intervals = Get number of intervals: tier
for i to intervals
  selectObject: textgrid
  start  = Get start point:       tier, i
  end    = Get end point:         tier, i
  label$ = Get label of interval: tier, i

  textgrid[i] = Extract part: start, end, preserve_times
  Rename: label$

  if sound
    selectObject: sound
    sound[i] = Extract part: start, end, "rectangular", 1, preserve_times
    Rename: label$
  endif
endfor

nocheck selectObject: undefined
for i to intervals
  plusObject: textgrid[i]
  if sound
    plusObject: sound[i]
  endif
endfor
