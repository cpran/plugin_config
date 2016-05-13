form Find label from end...
  integer  Tier 1
  sentence Target
  integer  Start_from 1
endform

appendInfoLine: "W: ""Find label from end..."" is deprecated; ",
   ... "use ""Find label behind..."" instead"

runScript: "find_label_behind.praat", tier, target$, start_from
