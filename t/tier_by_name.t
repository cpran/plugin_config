include ../../plugin_tap/procedures/more.proc
include ../../plugin_tgutils/procedures/get_tier_by_name.proc

preferencesDirectory$ = replace_regex$(preferencesDirectory$, "(con)?(\.(EXE|exe))?$", "", 0)

@plan(14)

tgutils$ = preferencesDirectory$ + "/plugin_tgutils/scripts/"
synth = Create SpeechSynthesizer: "English", "default"
To Sound: "This is some text", "yes"

sound    = selected("Sound")
textgrid = selected("TextGrid")

selectObject: textgrid
tiers = Get number of tiers
segment_tier = 4
segments = Get number of intervals: segment_tier

Insert point tier: tiers + 1, "points"
for i to segments-1
  time = Get end point: segment_tier, i
  Insert point: tiers + 1, time, string$(i)
endfor

@getTierByName: "clause"
@ok: getTierByName.return == 2,
  ... "finds existing interval tier"

@getTierByName: "points"
@ok: getTierByName.return == 5,
  ... "finds existing point tier"

@getTierByName: "fake"
@ok: !getTierByName.return,
  ... "does not find missing tier"

@getTierByName: ""
@ok: !getTierByName.return,
  ... "does not find tier with empty string"

Set tier name: 5, "añejó"

@getTierByName: "añejó"
@ok: getTierByName.return == 5,
  ... "finds tier with unicode string"

Set tier name: 5, "あいうえお"

@getTierByName: "あいうえお"
@ok: getTierByName.return == 5,
  ... "finds tier with hiragana string"

Set tier name: 5, "音声学"

@getTierByName: "音声学"
@ok: getTierByName.return == 5,
  ... "finds tier with kanji string"

Set tier name: 5, "points"

# Scripts

runScript: tgutils$ + "get_tier_by_name.praat", "clause"
@ok: number(info$()) == 2,
  ... "script finds existing interval tier"

runScript: tgutils$ + "get_tier_by_name.praat", "points"
@ok: number(info$()) == 5,
  ... "script finds existing point tier"

runScript: tgutils$ + "get_tier_by_name.praat", "fake"
@ok: number(info$()) == 0,
  ... "script does not find missing tier"

runScript: tgutils$ + "get_tier_by_name.praat", ""
@ok: number(info$()) == 0,
  ... "script does not find tier with empty string"

Set tier name: 5, "añejó"

runScript: tgutils$ + "get_tier_by_name.praat", "añejó"
@ok: number(info$()) ==  5,
  ... "script finds tier with unicode string"

Set tier name: 5, "あいうえお"

runScript: tgutils$ + "get_tier_by_name.praat", "あいうえお"
@ok: number(info$()) ==  5,
  ... "script finds tier with hiragana string"

Set tier name: 5, "音声学"

runScript: tgutils$ + "get_tier_by_name.praat", "音声学"
@ok: number(info$()) ==  5,
  ... "script finds tier with kanji string"

removeObject: sound, textgrid, synth

@done_testing()
