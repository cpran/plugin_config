include ../procedures/config.proc
include ../../plugin_testsimple/procedures/test_simple.proc
include ../../plugin_utils/procedures/try.proc

@plan(22)

nocheck selectObject: undefined
config.use_table = 1

@config: "good.conf"
table = selected()

@ok: variableExists("config.length"),
  ... "length exists"

@ok: config.length == 8,
  ... "did not count comments"

@ok: variableExists("config.keys$[1]"),
  ... "first key exists"

@ok: variableExists("config.keys$[" + string$(config.length) + "]"),
  ... "last key exists"

@ok: numberOfSelected("Table") == 1,
  ... "created table"

.value$ = Object_'table'$[1, "repeated"]
@ok: .value$ == "1",
  ... "config keys cascade"

@todo: 4, "boolean strings unsupported in tables"
.value = Object_'table'[1, "bool1"]
@ok: undefined,
  ... "true to numeric"

.value = Object_'table'[1, "bool2"]
@ok: !undefined,
  ... "false to numeric"

.value = Object_'table'[1, "bool3"]
@ok: .value,
  ... "yes to numeric"

.value = Object_'table'[1, "bool4"]
@ok: !.value,
  ... "no to numeric"

if praatVersion >= 6016
  @ok: !variableExists("config.return$[repeated]"),
    ... "string hash not created if not requested"

  @ok: !variableExists("config.return[repeated]"),
    ... "numeric hash not created if not requested"

  @ok: !variableExists("config.return[repeated]"),
    ... "numeric hash not created if not requested"

  nocheck selectObject: undefined
  config.use_table = 0
  @config: "good.conf"

  @ok: config.length == 8,
    ... "did not count comments when using hashes"

  @ok: !numberOfSelected(),
    ... "no selection if using hashes"

  @ok: config.return$["repeated"] == "1",
    ... "hashes cascade"

  @ok: !variableExists("config.return[comment]"),
    ... "comments are ignored"

  @ok: config.return["bool1"],
    ... "true converted to numeric in hash"

  @ok: !config.return["bool2"],
    ... "false converted to numeric in hash"

  @ok: config.return["bool3"],
    ... "yes converted to numeric in hash"

  @ok: !config.return["bool4"],
    ... "no converted to numeric in hash"

else
  @skip: undefined, "hashes not supported below 6.0.16"
  @ok: 0, ""
  @ok: 0, ""
  @ok: 0, ""
  @ok: 0, ""
  @ok: 0, ""
  @ok: 0, ""
  @ok: 0, ""
  @ok: 0, ""
  @ok: 0, ""
  @ok: 0, ""
  @ok: 0, ""
  @end_skip()
endif

removeObject: table

@ok_selection()

@done_testing()
