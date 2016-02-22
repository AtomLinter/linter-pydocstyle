# LinterPEP257 = require '../lib/init'

describe "when everything is started up", ->
  it "has some expectations that should pass", ->
    expect("apples").toEqual("apples")
    expect("oranges").not.toEqual("apples")
