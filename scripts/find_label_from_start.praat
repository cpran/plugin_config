form Find label from start...
  integer  Tier 1
  sentence Target
  integer  Start_from 1
endform

appendInfoLine: "W: ""Find label from start..."" is deprecated; ",
   ... "use ""Find label ahead..."" instead"

runScript: "find_label_ahead.praat", tier, target$, start_from
