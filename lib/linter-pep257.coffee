linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"

class Linterpep257 extends Linter
  @syntax: 'source.python'
  linterName: 'pep257'
  errorStream: 'stderr'
  defaultLevel: 'warning'

  # Regex to capture output such as:
  #   /Path/to/file.py:1 at module level:
  #     D100: Docstring missing"
  # line: the line number on which to mark error
  # message: the message to show in the linter views
  regex: ':(?<line>\\d+).*\\s+(?<message>.*)'

  constructor: (editor)->
    super(editor)
    atom.config.observe 'linter-pep257.execPath', => @updateCommand()
    atom.config.observe 'linter-pep257.ignoreCodes', => @updateCommand()

  destroy: ->
    atom.config.unobserve 'linter-pep257.execPath'
    atom.config.unobserve 'linter-pep257.ignoreCodes'

  updateCommand: ->
    cmd = [atom.config.get 'linter-pep257.execPath']
    ignoreCodes = atom.config.get 'linter-pep257.ignoreCodes'
    cmd.push "--ignore=#{ignoreCodes}" if ignoreCodes
    @cmd = cmd

module.exports = Linterpep257
