# Index all matching labels in a TextGrid tier
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

form Find all labels...
  integer    Tier 1
  sentence   Target .*
  boolean    Regular_expression 1
endform

include ../procedures/find_label.proc

if !regular_expression
  find_label.regex = 0
endif

textgrid = selected("TextGrid")
is_interval = Is interval tier: tier
item$ = if is_interval then "interval" else "point" fi
total_items = do("Get number of " + item$ + "s...", tier)

table = Create Table with column names: "indices", 0,
  ... "index label" + if is_interval then " start end" else " time" fi

found = undefined
i = 0
repeat
  selectObject: textgrid
  @findLabelAhead: tier, target$, i+1
  found = findLabelAhead.return

  if found
    i = found
    selectObject: textgrid
    if is_interval
      start  = Get start point:       tier, found
      end    = Get end point:         tier, found
      label$ = Get label of interval: tier, found
    else
      time   = Get time of point:     tier, found
      label$ = Get label of point:    tier, found
    endif

    selectObject: table
    Append row
    this_row = Get number of rows
    Set numeric value: this_row, "index", found
    Set string value:  this_row, "label", label$
    if is_interval
      Set numeric value: this_row, "start", start
      Set numeric value: this_row, "end",   end
    else
      Set numeric value: this_row, "time",  time
    endif
  endif
until i >= total_items or !found

selectObject: table
