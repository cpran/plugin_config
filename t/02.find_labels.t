include ../../plugin_testsimple/procedures/test_simple.proc
include ../procedures/find_label.proc

@no_plan()

synth = Create SpeechSynthesizer: "English", "default"
To Sound: "This is some text", "yes"

sound    = selected("Sound")
textgrid = selected("TextGrid")

selectObject: textgrid
tiers = Get number of tiers
intervals = Get number of intervals: 4

Insert point tier: tiers + 1, "points"
for i to intervals-1
  time = Get end point: 4, i
  Insert point: tiers + 1, time, string$(i)
endfor

@findLabel: 4, "s"
@ok: findLabel.return,
  ... "finds existing label"

@findLabel: 4, "x"
@ok: !findLabel.return,
  ... "cannot find missing label"

@findLabel: 3, "hi"
@ok: findLabel.return,
  ... "label is regular expression"

find_label.regex = 0
@findLabel: 3, "hi"
@ok: !findLabel.return,
  ... "label is not regular expression"

@findLabelAhead: 4, "s", 1
@ok: findLabelAhead.return,
  ... "find label from start"

last_interval = Get number of intervals: 3
@findLabelBehind: 4, "s", last_interval
@ok: findLabelBehind.return,
  ... "find label from end"

@ok_formula: "findLabelBehind.return != findLabelAhead.return",
  ... "from start and end differ"

first = findLabelAhead.return

@findLabelAhead: 4, "s", first + 1
@ok: findLabelAhead.return,
  ... "finds ahead after offset"
@ok_formula: "findLabelAhead.return > first",
  ... "finds next after first"

second = findLabelAhead.return

@findNthLabel: 4, "s", 2
@ok: findNthLabel.return,
  ... "finds nth label"
@ok_formula: "findNthLabel.return = second",
  ... "2nd label is first after first"

@findLabel: 4, "ɪ"
@ok: findLabel.return,
  ... "find unicode label"

@findLabel: 5, "2"
@ok: findLabel.return,
  ... "find point labels"

removeObject: sound, textgrid, synth

@done_testing()
