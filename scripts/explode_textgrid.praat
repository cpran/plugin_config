# Separate a TextGrid into interval-sized parts
#
# Author:  Jose Joaquin Atria
#
# This script is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of
# the License, or (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

form Explode TextGrid...
  integer Tier 1
  boolean Preserve_times 0
endform

interval = Is interval tier: tier
if !interval
  exit Not an interval tier
endif

textgrid = selected("TextGrid")

intervals = Get number of intervals: tier
for i to intervals
  selectObject: textgrid
  start  = Get start point:       tier, i
  end    = Get end point:         tier, i
  label$ = Get label of interval: tier, i

  part[i] = Extract part: start, end, preserve_times
  Rename: label$
endfor

nocheck selectObject: undefined
for i to intervals
  plusObject: part[i]
endfor
