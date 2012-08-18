
Task = require './task'
TaskStatus = require './taskstatus'

class CompositeTask extends Task
  constructor: -> 
    @tasks = []
    @runningTask = null
  add: (task) -> 
    @tasks.push task

  execute: -> 
    throw new Error 'CompositeTask cannot execute tasks'

  executeChild: (task) ->
    # If the executed task is different from the running task ensure that the
    # running task is gracefully deactivated
    if task isnt @runningTask
      @runningTask.deactivate() if @runningTask?
      task.activate()

    status = task.execute()

    # If the task finished executing, deactivate it. Otherwise, flag it as the currently running task
    if status isnt TaskStatus.RUNNING
      task.deactivate()
      @runningTask = null
    else
      @runningTask = task

    status

module.exports = CompositeTask