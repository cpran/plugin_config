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
# Copyright 2013-2016 Jose Joaquin Atria

include ../../plugin_tgutils/procedures/textgrid_to_audacity_label.proc
include ../../plugin_utils/procedures/check_directory.proc
include ../../plugin_utils/procedures/check_filename.proc
include ../../plugin_utils/procedures/require.proc
@require("5.3.44")

#! ~~~ params
#! in:
#!   Tier: >
#!     (integer) The tier to process
#!   Save to: >
#!     (sentence) The directory where to (optionally) save the labels
#!   Print to Info: >
#!     (boolean) If true, labels will be printed. Otherwise, they'll be
#!     saved to disk.
#! selection:
#!   in:
#!     textgrid: 1-
#! ~~~
#! Convert TextGrid interval tier to Audacity label track
#!
#! Converts selected TextGrid objects to Audacity labels and
#! either saves them to external files or prints them  to the
#! Info window.
#!
form TextGrid tier to Audacity label track...
  integer Tier 1
  sentence Save_to
  comment Leave path empty for GUI selector
  boolean Print_to_Info no
endform

info = print_to_Info

total_textgrids = numberOfSelected("TextGrid")

if !info
  if total_textgrids > 1
    @checkDirectory(save_to$, "Choose output directory...")
    path$ = checkDirectory.name$
  else
    @checkFilename(save_to$, "Choose output file...")
    path$ = checkFilename.name$
  endif
else
  path$ = ""
endif

for i to total_textgrids
  tg[i] = selected("TextGrid", i)
endfor

if info and total_textgrids
  clearinfo
endif

for i to total_textgrids
  selectObject: tg[i]
  name$ = selected$("TextGrid")
  total_intervals = Get number of intervals: tier

  outfile$ = ""
  if !info
    if total_textgrids > 1
      outfile$ = path$ + name$ + ".txt"
    else
      outfile$ = path$
    endif

    if fileReadable(outfile$)
      appendInfoLine: "Overwriting existing file ", outfile$, "..."
      deleteFile(outfile$)
    endif
  elsif total_textgrids > 1
    appendInfoLine("-- Begin label for ", name$, " --")
  endif

  @tierToAudacityLabel: tier, outfile$

  if total_textgrids > 1 and info
    appendInfoLine("-- End label for ", name$, " --")
  endif
endfor

# Restore original selection
if total_textgrids
  nocheck selectObject: undefined
  for i to total_textgrids
    plusObject(tg[i])
  endfor
endif
