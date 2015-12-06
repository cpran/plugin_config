# Setup script for tgutils
#
# Find the latest version of this plugin at
# https://gitlab.com/cpran/plugin_tgutils
#
# Written by Jose Joaquín Atria
#
# This script is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# A copy of the GNU General Public License is available at
# <http://www.gnu.org/licenses/>.

## Static commands:

# TODO: Add missing commands

# Base menu
nocheck Add menu command: "Objects", "Praat", "tgutils", "CPrAN", 1, ""

# Batch scripts menu
nocheck Add menu command: "Objects", "Praat", "TextGrids to Audacity labels...", "tgutils", 2, "scripts/batch_textgrids_to_audacity_labels.praat"

## Dynamic commands

# TextGrid commands
Add action command: "TextGrid", 1, "",          0, "", 0, "Find label...",                        "Query -",          1, "scripts/find_label_in_textgrid.praat"
Add action command: "TextGrid", 1, "",          0, "", 0, "Find all labels...",                   "Query -",          1, "scripts/index_specified_labels.praat"
Add action command: "TextGrid", 1, "",          0, "", 0, "Index specified labels...",            "Query -",          1, "scripts/index_specified_labels.praat"
Add action command: "TextGrid", 1, "",          0, "", 0, "Get tier by name...",                  "Query -",          1, "scripts/get_tier_by_name.praat"
Add action command: "TextGrid", 0, "",          0, "", 0, "Save as Audacity label...",            "",                 0, "scripts/textgrid_to_audacity_label.praat"
Add action command: "TextGrid", 1, "",          0, "", 0, "Count points in range...",             "Query point tier", 2, "scripts/count_points_in_range.praat"
Add action command: "TextGrid", 1, "",          0, "", 0, "Explode TextGrid...",                  "",                 0, "scripts/explode_textgrid.praat"
Add action command: "TextGrid", 1, "Sound",     1, "", 0, "Explode TextGrid...",                  "",                 0, "scripts/explode_textgrid.praat"
Add action command: "TextGrid", 1, "Sound",     1, "", 0, "Move boundaries to zero crossings...", "Modify times",     2, "scripts/move_to_zero_crossings.praat"
Add action command: "TextGrid", 1, "Sound",     1, "", 0, "Extract labels...",                    "",                 0, "scripts/extract_labels.praat"
Add action command: "TextGrid", 1, "LongSound", 1, "", 0, "Extract labels...",                    "",                 0, "scripts/extract_labels.praat"
