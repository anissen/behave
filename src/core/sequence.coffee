CompositeTask = require './compositetask'
TaskStatus = require './taskstatus'

class Sequence extends CompositeTask
  execute: ->
    for task in @tasks
      status = task.execute()
      return status if status isnt TaskStatus.SUCCESS
    TaskStatus.SUCCESS

module.exports = Sequence