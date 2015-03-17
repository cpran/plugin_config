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

# Uncomment next line to run tests at startup
# runScript: "run_tests.praat"

# TODO: Add missing commands

# Base menu
Add menu command: "Objects", "Praat", "CPrAN",   "", 0, ""
Add menu command: "Objects", "Praat", "Tgutils", "", 1, ""

# Batch scripts menu
Add menu command: "Objects", "Praat", "Move boundaries to zero crossings...",       "Tgutils", 2, "scripts/move_to_zero_crossings.praat"
Add menu command: "Objects", "Praat", "Generate Pitch (two-pass)...",               "Tgutils", 2, "scripts/batch_to_pitch_two-pass.praat"
Add menu command: "Objects", "Praat", "TextGrids to Audacity labels...",            "Tgutils", 2, "scripts/batch_textgrids_to_audacity_labels.praat"

## Dynamic commands

# TextGrid commands
Add action command: "TextGrid", 1, "",         0, "", 0, "Find label...",                        "Query -",               1, "textgrid/find_label_in_textgrid.praat"
Add action command: "TextGrid", 0, "",         0, "", 0, "Save as Audacity label...",            "",                      0, "textgrid/textgrid_to_audacity_label.praat"
Add action command: "TextGrid", 1, "",         0, "", 0, "Count points in range...",             "Query point tier",      2, "textgrid/count_points_in_range.praat"
