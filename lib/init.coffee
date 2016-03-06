{CompositeDisposable} = require 'atom'
helpers = require 'atom-linter'

module.exports =
  config:
    executablePath:
      title: 'Executable Path'
      type: 'string'
      default: 'pydocstyle'
      description: "Path to executable pydocstyle cmd."
    ignoreCodes:
      type: 'string'
      default: ''
      description: ('Comma separated list of error codes to ignore. ' +
        'Available codes: https://pypi.python.org/pypi/pydocstyle#error-codes')
    ignoreFiles:
      type: 'string'
      default: ''
      description: 'Filename pattern to ignore, e.g.: test_; Restart Atom to activate/deactivate.'

  activate: ->
    require('atom-package-deps').install('linter-pydocstyle')
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.config.observe 'linter-pydocstyle.executablePath',
      (executablePath) =>
        @executablePath = executablePath
    @subscriptions.add atom.config.observe 'linter-pydocstyle.ignoreCodes',
      (ignoreCodes) =>
        @ignoreCodes = ignoreCodes
    @subscriptions.add atom.config.observe 'linter-pydocstyle.ignoreFiles',
      (ignoreFiles) =>
        @ignoreFiles = ignoreFiles

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
                             "^(?<file>.+):(?<line>\\d+).+ \\| (?<message>.+)",
                             {flags: 'gm'})
    messages.forEach (msg) ->
      msg.type = "Info"
    return messages

  provideLinter: ->
    provider =
      grammarScopes: ['source.python']
      scope: 'file'
      lintOnFly: false
      lint: (textEditor) =>
        if (@ignoreFiles == '' || textEditor.getPath().indexOf(@ignoreFiles) == -1)
          return @lintPath textEditor.getPath()
            .then @parseMessages
