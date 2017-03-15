include ../procedures/config.proc
include ../../plugin_tap/procedures/more.proc

@plan: 11

nocheck selectObject: undefined
config.use_table = 1

@config: "sections.conf"

@is: numberOfSelected("Table"), 3,
  ... "sections in separate Table objects"

nocheck selectObject: "Table config_default"
@is: numberOfSelected("Table"), 1,
  ... "default section has table"
default = selected()

nocheck selectObject: "Table config_foo"
@is: numberOfSelected("Table"), 1,
  ... "foo section has table"
foo = selected()

nocheck selectObject: "Table config_bar"
@is: numberOfSelected("Table"), 1,
  ... "bar section has table"
bar = selected()

a$ = Table_config_default$[1, "foo"]
b$ = Table_config_foo$[    1, "foo"]
@isnt$: a$, b$,
  ... "sections are scoped"

removeObject: default, foo, bar

if praatVersion >= 6016
  @is_false: variableExists("config.return$[foo]"),
    ... "string hash not created if not requested"

  @is_false: variableExists("config.return[foo]"),
    ... "numeric hash not created if not requested"

  selectObject()
  config.use_table = 0
  @config: "sections.conf"

  @is: config.length, 9,
    ... "length counts all keys in all sections"

  @is$: config.return$["foo"], "1",
    ... "keys in default section are plain"

  @is$: config.return$["bar:foo"], "A",
    ... "keys in other sections are qualified"

else
  @skip: undefined, "hashes not supported below 6.0.16"
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @fail: ""
  @end_skip()
endif

@ok_selection()

@done_testing()
