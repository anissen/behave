
TaskStatus = require './taskstatus'

class CompositeTask
  constructor: -> 
  	@tasks = []
  	@runningTask = null
  add: (task) -> 
  	@tasks.push task
  decide: -> 
  	true
  execute: -> 
  	throw new Error 'CompositeTask cannot execute tasks'

module.exports = CompositeTask