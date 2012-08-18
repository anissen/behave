CompositeTask = require './compositetask'
TaskStatus = require './taskstatus'

class Sequence extends CompositeTask
  execute: ->
    for task in @tasks
      # If there is a running task, skip children until we reach the running task
      # If there is not a running task , skip children who do not accept
      continue if (@runningTask? and task isnt @runningTask) or (not task.decide()) # Skip non−running non−accepting tasks

      # At this point in execution we have either the running task or a non− running but accepting task
      status = @executeChild task

      # If the task either fails or continues to run we are finished. Otherwise we continue to the next child.
      return status if status isnt TaskStatus.SUCCESS
      
    TaskStatus.SUCCESS

module.exports = Sequence