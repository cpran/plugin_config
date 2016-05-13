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
# Copyright 2014-2016 Jose Joaquin Atria

include ../procedures/find_label.proc

#! ~~~ params
#! in:
#!   Tier: >
#!     (integer) Tier where to perform the search
#!   Target: >
#!     (sentence) Target string to search for
#!   Start from: >
#!     (integer) Index of starting point or interval
#! selection:
#!   in:
#!     textgrid: 1
#! ~~~
#!
#! Look for the first matching label in a TextGrid tier after (ie. to
#! the right of) the specified index.
#!
#! A negative starting index will be counted from the end, such that starting
#! from passing index `-5` will start looking from the fifth-to-last point
#! or interval. Using `-1` will look only in the last interval or point
#! (because the search is still performed forwards).
#!
form Find label ahead...
  integer  Tier 1
  sentence Target
  integer  Start_from 1
endform

@findLabelAhead(tier, target$, start_from)

writeInfoLine: findLabelAhead.return
