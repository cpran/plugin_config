include ../../plugin_testsimple/procedures/test_simple.proc
include ../procedures/find_label.proc

preferencesDirectory$ = replace_regex$(preferencesDirectory$, "(con)?(\.(EXE|exe))?$", "", 0)

@no_plan()

tgutils$ = preferencesDirectory$ + "/plugin_tgutils/scripts/"
synth = Create SpeechSynthesizer: "English", "default"
To Sound: "This is some text", "yes"

word_tier    = 3
segment_tier = 4

sound    = selected("Sound")
textgrid = selected("TextGrid")

selectObject: textgrid
tiers = Get number of tiers
segments = Get number of intervals: segment_tier

Insert point tier: tiers + 1, "points"
for i to segments-1
  time = Get end point: 4, i
  Insert point: tiers + 1, time, string$(i)
endfor

point_tier   = 5

@findLabel: segment_tier, "s"
@ok: findLabel.return == 4,
  ... "finds existing label"

@findLabel: segment_tier, "x"
@ok: !findLabel.return,
  ... "cannot find missing label"

@findLabel: word_tier, "hi"
@ok: findLabel.return == 2,
  ... "label is regular expression"

find_label.regex = 0
@findLabel: word_tier, "hi"
@ok: !findLabel.return,
  ... "label is not regular expression"

@findLabelAhead: segment_tier, "s", 1
@ok: findLabelAhead.return,
  ... "find label from start"

@findLabelBehind: segment_tier, "s", 5
@ok: findLabelBehind.return == 4,
  ... "find label from end, counting forward"

@findLabelBehind: segment_tier, "s", -1
@ok: findLabelBehind.return == 16,
  ... "find label from end, counting backwards"

@ok_formula: "findLabelBehind.return != findLabelAhead.return",
  ... "from start and end differ in same direction"

first = findLabelAhead.return

@findLabelAhead: segment_tier, "s", first + 1
@ok: findLabelAhead.return,
  ... "finds ahead after offset"
@ok_formula: "findLabelAhead.return > first",
  ... "finds next after first"

second = findLabelAhead.return

@findNthLabel: segment_tier, "s", 2
@ok: findNthLabel.return,
  ... "finds nth label"
@ok_formula: "findNthLabel.return = second",
  ... "2nd label is first after first"

@findNthLabel: segment_tier, "s", 0
@ok: findNthLabel.return == undefined,
  ... "0th element is undefined"

@findLabel: segment_tier, "ɪ"
@ok: findLabel.return,
  ... "find unicode label"

@findLabel: point_tier, "2"
@ok: findLabel.return,
  ... "find point labels"

# Scripts

runScript: tgutils$ + "find_label_in_textgrid.praat",
  ... segment_tier, "s", "Forwards", 1

runScript: tgutils$ + "find_label_in_textgrid.praat",
  ... segment_tier, "s", "Backwards", 1

runScript: tgutils$ + "find_label_in_textgrid.praat",
  ... segment_tier, "x", "Forwards", 1

runScript: tgutils$ + "find_label_in_textgrid.praat",
  ... segment_tier, "x", "Backwards", 1

runScript: tgutils$ + "find_label_from_start.praat",
  ... segment_tier, "s", 1

runScript: tgutils$ + "find_label_from_start.praat",
  ... segment_tier, "s", 1

runScript: tgutils$ + "find_label_from_start.praat",
  ... segment_tier, "x", 1

runScript: tgutils$ + "find_label_from_start.praat",
  ... segment_tier, "x", 1

runScript: tgutils$ + "find_label_from_end.praat",
  ... segment_tier, "s", -1

runScript: tgutils$ + "find_label_from_end.praat",
  ... segment_tier, "s", -1

runScript: tgutils$ + "find_label_from_end.praat",
  ... segment_tier, "x", -1

runScript: tgutils$ + "find_label_from_end.praat",
  ... segment_tier, "x", -1

removeObject: sound, textgrid, synth

@done_testing()
