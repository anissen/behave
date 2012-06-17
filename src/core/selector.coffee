
CompositeTask = require './compositetask'
TaskStatus = require './taskstatus'

class Selector extends CompositeTask
  execute: ->
    for task in @tasks
      status = task.execute()
      return status if status isnt TaskStatus.FAILURE
    TaskStatus.FAILURE

module.exports = Selector