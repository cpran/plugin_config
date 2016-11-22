include ../procedures/config.proc
include ../../plugin_tap/procedures/more.proc

@plan(22)

nocheck selectObject: undefined
config.use_table = 1

@config: "good.conf"
table = selected()

@is_true: variableExists("config.length"),
  ... "length exists"

@is: config.length, 8,
  ... "did not count comments"

@is_true: variableExists("config.keys$[1]"),
  ... "first key exists"

@is_true: variableExists("config.keys$[" + string$(config.length) + "]"),
  ... "last key exists"

@is: numberOfSelected("Table"), 1,
  ... "created table"

.value$ = Object_'table'$[1, "repeated"]
@is$: .value$, "1",
  ... "config keys cascade"

@todo: 4, "boolean strings unsupported in tables"
.value = Object_'table'[1, "bool1"]
@is_true: .value,
  ... "true to numeric"

.value = Object_'table'[1, "bool2"]
@is_false: .value,
  ... "false to numeric"

.value = Object_'table'[1, "bool3"]
@is_true: .value,
  ... "yes to numeric"

.value = Object_'table'[1, "bool4"]
@is_false: .value,
  ... "no to numeric"

if praatVersion >= 6016
  @is_false: variableExists("config.return$[repeated]"),
    ... "string hash not created if not requested"

  @is_false: variableExists("config.return[repeated]"),
    ... "numeric hash not created if not requested"

  nocheck selectObject: undefined
  config.use_table = 0
  @config: "good.conf"

  @is: config.length, 8,
    ... "did not count comments when using hashes"

  @is: numberOfSelected(), 0,
    ... "no selection if using hashes"

  @is$: config.return$["repeated"], "1",
    ... "hashes cascade"

  @is_false: variableExists("config.return[comment]"),
    ... "comments are ignored"

  @is_true: config.return["bool1"],
    ... "true converted to numeric in hash"

  @is_false: config.return["bool2"],
    ... "false converted to numeric in hash"

  @is_true: config.return["bool3"],
    ... "yes converted to numeric in hash"

  @is_false: config.return["bool4"],
    ... "no converted to numeric in hash"

else
  @skip: undefined, "hashes not supported below 6.0.16"
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @end_skip()
endif

removeObject: table

@ok_selection()

@done_testing()
