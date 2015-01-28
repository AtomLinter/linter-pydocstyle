module.exports =
  config:
    execPath:
      type: 'string'
      default: 'pep257'
      description: "Path to executable pep257 cmd."
    ignoreCodes:
      type: 'string'
      default: ''
      description: ('Comma separated list of error codes to ignore. ' +
        'Available codes: https://pypi.python.org/pypi/pep257#error-codes')

  activate: ->
    console.log 'activate linter-pep257'
