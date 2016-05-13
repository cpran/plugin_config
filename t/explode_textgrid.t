include ../../plugin_tap/procedures/simple.proc
include ../procedures/find_label.proc

@no_plan()

synth = Create SpeechSynthesizer: "English", "default"
To Sound: "This is some text", "yes"

word_tier    = 3
segment_tier = 4

sound    = selected("Sound")
textgrid = selected("TextGrid")

selectObject: textgrid
intervals = Get number of intervals: word_tier
runScript: preferencesDirectory$ +
  ... "/plugin_tgutils/scripts/explode_textgrid.praat", word_tier, "no"
@ok_formula: "numberOfSelected(""TextGrid"") = intervals",
  ... "explode textgrid"
Remove

selectObject: sound, textgrid
runScript: preferencesDirectory$ +
  ... "/plugin_tgutils/scripts/explode_textgrid.praat", word_tier, "no"
@ok_formula: "numberOfSelected(""TextGrid"") = intervals and " +
  ...        "numberOfSelected(""Sound"") = intervals",
  ... "explode textgrid and sound"
Remove

removeObject: sound, textgrid, synth

@ok_selection()

@done_testing()
