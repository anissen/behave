CompositeTask = require './compositetask'
TaskStatus = require './taskstatus'

class Sequence extends CompositeTask
  execute: ->
    for task in @tasks
      continue if @runningTask? and task isnt @runningTask

      status = task.execute()

      if status is TaskStatus.RUNNING
      	@runningTask = task
      else
        @runningTask = null
        
      return status if status isnt TaskStatus.SUCCESS
    TaskStatus.SUCCESS

module.exports = Sequence