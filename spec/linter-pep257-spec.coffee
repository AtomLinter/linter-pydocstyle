LinterPEP257 = require '../lib/init'
path = require 'path'

goodPath = path.join(__dirname, 'fixtures', 'good.py')
badPath = path.join(__dirname, 'fixtures', 'bad.py')
emptyPath = path.join(__dirname, 'fixtures', 'empty.py')

describe "starts everything up", ->
  lint = require('../lib/init').provideLinter().lint
  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('linter-pep257')
    waitsForPromise ->
      atom.packages.activatePackage("language-python")

  it 'should be in the package list', ->
    expect(atom.packages.isPackageLoaded('linter-pep257')).toBe true

  it 'should have activated the package', ->
    expect(atom.packages.isPackageActive('linter-pep257')).toBe true

  describe "reads good.py and", ->
    editor = null
    beforeEach ->
      waitsForPromise ->
        atom.workspace.open(goodPath).then (e) ->
          editor = e

    it 'finds nothing to complain about', ->
      messages = null
      waitsForPromise ->
        lint(editor).then (msgs) -> messages = msgs
      runs ->
        expect(messages.length).toEqual 0

  describe "reads bad.py and", ->
    editor = null
    beforeEach ->
      waitsForPromise ->
        atom.workspace.open(badPath).then (e) ->
          editor = e

    it 'finds something to complain about', ->
      messages = null
      waitsForPromise ->
        lint(editor).then (msgs) -> messages = msgs
      runs ->
        expect(messages.length).toBeGreaterThan 0
