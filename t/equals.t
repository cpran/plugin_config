include ../procedures/config.proc
include ../../plugin_tap/procedures/more.proc

@no_plan()

nocheck selectObject: undefined
config.use_table = 1
config.separator$ = "=="

@config: "equals.conf"
table = selected()

@is_true: variableExists("config.length"),
  ... "length exists"

@is: config.length, 2,
  ... "count entries"

@is_true: variableExists("config.keys$[1]"),
  ... "first key exists"

@is_true: variableExists("config.keys$[" + string$(config.length) + "]"),
  ... "last key exists"

@is: numberOfSelected("Table"), 1,
  ... "created table"

@is$: config.keys$[1], "hello: world",
  ... "changed separator string"

.value = Object_'table'[1, "repeated"]
@is: .value, 350,
  ... "good numeric value"

.value$ = Object_'table'$[1, "repeated"]
@is$: .value$, "350",
  ... "good string value"

removeObject: table

@ok_selection()

@done_testing()
