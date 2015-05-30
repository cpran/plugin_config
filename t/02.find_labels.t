include ../../plugin_testsimple/procedures/test_simple.proc
include ../procedures/find_label.proc

@no_plan()

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
@ok: findLabel.return,
  ... "finds existing label"

@findLabel: segment_tier, "x"
@ok: !findLabel.return,
  ... "cannot find missing label"

@findLabel: word_tier, "hi"
@ok: findLabel.return,
  ... "label is regular expression"

find_label.regex = 0
@findLabel: word_tier, "hi"
@ok: !findLabel.return,
  ... "label is not regular expression"

@findLabelAhead: segment_tier, "s", 1
@ok: findLabelAhead.return,
  ... "find label from start"

@findLabelBehind: segment_tier, "s", 1
@ok: findLabelBehind.return,
  ... "find label from end"

@ok_formula: "findLabelBehind.return != findLabelAhead.return",
  ... "from start and end differ"

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

@findLabel: segment_tier, "ɪ"
@ok: findLabel.return,
  ... "find unicode label"

@findLabel: point_tier, "2"
@ok: findLabel.return,
  ... "find point labels"

removeObject: sound, textgrid, synth

@done_testing()
