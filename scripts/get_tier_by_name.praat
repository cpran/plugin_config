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
# Copyright 2015-2016 Jose Joaquin Atria

include ../procedures/get_tier_by_name.proc

#! ~~~ params
#! in:
#!   Tier name: >
#!     (word) The name of the tier to search for
#! selection:
#!   in:
#!     textgrid: 1
#! ~~~
#!
#! Run with a selected TextGrid, it looks for the first tier with a name
#! matching the one provided, and prints its index to the Info window (or
#! STDOUT).
#!
form Get tier by name...
  word Tier_name
endform

@getTierByName: tier_name$

writeInfoLine: getTierByName.return
