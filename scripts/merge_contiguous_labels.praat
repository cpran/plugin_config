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
# Copyright 2016 Jose Joaquin Atria

include ../../plugin_tgutils/procedures/merge_contiguous_labels.proc

#! ~~~ params
#! in:
#!   Tier: >
#!     (integer) The interval tier to process
#! selection:
#!   in:
#!     textgrid: 1
#!   out:
#!     textgrid: 1
#! ~~~
#!
#! Merge contiguous intervals with matching labels in an interval tier.
#!
#! This command creates a new TextGrid object. The original is unaffected.
#!
form Merge contiguous labels...
  positive Tier 1 (0 = all)
  comment  Only interval tiers are currently supported
endform

textgrid = Copy: selected$("TextGrid") + "_merged"

if !tier
  total_tiers = Get number of tiers
  for i to total_tiers
    @mergeContiguousLabels: i
  endfor
else
  @mergeContiguousLabels: tier
endif
