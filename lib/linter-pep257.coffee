linterPath = atom.packages.getLoadedPackage("linter").path
Linter = require "#{linterPath}/lib/linter"

configLabelCodes = 'linter-pep257.Error codes to ignore (comma separated)'
configLabelExec = 'linter-pep257.Path to executeable pep257 cmd'

class Linterpep257 extends Linter
  @syntax: 'source.python'

  cmd: 'pep257'
  executablePath: null
  linterName: 'pep257'
  errorStream: 'stderr'

  # Regex to capture output such as:
  #   /Path/to/file.py:1 at module level:
  #     D100: Docstring missing"
  # line: the line number on which to mark error
  # message: the message to show in the linter views
  regex: ':(?<line>\\d+).*\\s+(?<message>.*)'

  constructor: (editor)->

    super(editor)
    @executablePath = atom.config.get configLabelExec

    atom.config.observe configLabelCodes, =>
      @updateCommand()

  destroy: ->
    atom.config.unobserve configLabelCodes

  updateCommand: ->
    cmd = 'pep257'
    errorCodes = atom.config.get configLabelCodes
    if errorCodes
      cmd = "#{cmd} --ignore=#{errorCodes}"
    @cmd = cmd

module.exports = Linterpep257
