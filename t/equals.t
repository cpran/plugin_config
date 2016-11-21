include ../procedures/config.proc
include ../../plugin_testsimple/procedures/test_simple.proc

@no_plan()

nocheck selectObject: undefined
config.use_table = 1
config.separator$ = "=="

@config: "equals.conf"
table = selected()

@ok: variableExists("config.length"),
  ... "length exists"

@ok: config.length == 2,
  ... "count entries"

@ok: variableExists("config.keys$[1]"),
  ... "first key exists"

@ok: variableExists("config.keys$[" + string$(config.length) + "]"),
  ... "last key exists"

@ok: numberOfSelected("Table") == 1,
  ... "created table"

@ok: config.keys$[1] == "hello: world",
  ... "changed separator string"

.value = Object_'table'[1, "repeated"]
@ok: .value = 350,
  ... "good numeric value"

.value$ = Object_'table'$[1, "repeated"]
@ok: .value$ = "350",
  ... "good string value"

removeObject: table

@ok_selection()

@done_testing()
