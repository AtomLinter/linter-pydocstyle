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

    it 'finds the right things to complain about', ->
      messages = null
      waitsForPromise ->
        lint(editor).then (msgs) -> messages = msgs
      runs ->
        expect(messages[0].text).toEqual('D100: Missing docstring in public module')
        expect(messages[0].range).toEqual([[0,0],[0,0]])
        expect(messages[0].type).toEqual('Info')
        expect(messages[0].filePath).toEqual(badPath)
        expect(messages[1].text).toEqual('D103: Missing docstring in public function')
        expect(messages[1].range).toEqual([[0,0],[0,0]])
        expect(messages[1].type).toEqual('Info')
        expect(messages[1].filePath).toEqual(badPath)
