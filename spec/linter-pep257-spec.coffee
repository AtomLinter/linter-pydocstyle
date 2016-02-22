LinterPEP257 = require '../lib/init'

describe "when everything is started up", ->
  beforeEach ->
    waitsForPromise ->
      atom.workspace.open('fixtures/sample.py')
    waitsForPromise ->
      atom.packages.activatePackage('linter-pep257')

  it "has some expectations that should pass", ->
    expect("apples").toEqual("apples")
    expect("oranges").not.toEqual("apples")

  it 'should have waited long enough', ->
    expect(atom.packages.isPackageActive('linter-pep257')).toBe true
