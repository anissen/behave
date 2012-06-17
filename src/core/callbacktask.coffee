
class CallbackTask
  constructor: (@callback) ->
  	throw new Error 'callback function not set' unless @callback? and (typeof(@callback) is 'function')

  execute: ->
  	@callback()

module.exports = CallbackTask