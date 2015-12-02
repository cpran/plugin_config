# Count points in TextGrid tier within specified range
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

form Get points in range...
  integer Tier 1
  real    left_Start 0
  real    right_End 0 (= all)
endform

include ../procedures/count_points_in_range.proc

interval_tier = Is interval tier: tier

if !interval_tier

  start = left_Start
  end = right_End

  @countPointsInRange(tier, start, end)

  writeInfoLine: countPointsInRange.return
else
  exitScript: "Tier must be a point tier"
endif
