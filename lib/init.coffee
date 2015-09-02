{CompositeDisposable} = require 'atom'
helpers = require 'atom-linter'

module.exports =
  config:
    executablePath:
      title: 'Executable Path'
      type: 'string'
      default: 'pep257'
      description: "Path to executable pep257 cmd."
    ignoreCodes:
      type: 'string'
      default: ''
      description: ('Comma separated list of error codes to ignore. ' +
        'Available codes: https://pypi.python.org/pypi/pep257#error-codes')

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'linter-pep257.executablePath',
      (executablePath) =>
        @executablePath = executablePath
    @subscriptions.add atom.config.observe 'linter-pep257.ignoreCodes',
      (ignoreCodes) =>
        @ignoreCodes = ignoreCodes

  deactivate: ->
    @subscriptions.dispose()

  lintPath: (filePath)->
    params = [filePath]
    if @ignoreCodes
      params.push("--add-ignore=" + @ignoreCodes)
    return helpers.exec(@executablePath, params, {stream: 'stderr'})

  parseMessages: (output) ->
    # parse lint output
    output = output.replace(/:[\r\n]\s+/mg, " | ") # combine multiline output
    messages = helpers.parse(output,
                             "^(?<file>.+):(?<line>\\d+)\\s+(?<message>.+)")
    messages.forEach (msg) ->
      msg.type = "Info"
    return messages

  provideLinter: ->
    provider =
      grammarScopes: ['source.python']
      scope: 'file'
      lintOnFly: true
      lint: (textEditor) =>
        return @lintPath textEditor.getPath()
          .then @parseMessages
