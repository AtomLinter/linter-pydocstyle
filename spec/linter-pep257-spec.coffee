LinterPEP257 = require '../lib/init'

describe "when everything is started up", ->
  beforeEach ->
    waitsForPromise ->
      atom.workspace.open('fixtures/sample.py').then (e) ->
        editor = e
    waitsForPromise ->
      atom.packages.activatePackage('linter-pep257')
    waitsForPromise ->
      atom.packages.activatePackage("language-python")

  it "has some expectations that should pass", ->
    expect("apples").toEqual("apples")
    expect("oranges").not.toEqual("apples")

  it 'should be in the package list', ->
    expect(atom.packages.isPackageLoaded('linter-pep257')).toBe true

  it 'should have activated the package', ->
    expect(atom.packages.isPackageActive('linter-pep257')).toBe true
