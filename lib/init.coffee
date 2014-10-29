module.exports =
  config:
    "Error codes to ignore (comma separated)":
      type: 'string'
      default: ''
    "Path to executable pep257 cmd":
      type: 'string'
      default: 'pep257'

  activate: ->
    console.log 'activate linter-pep257'
