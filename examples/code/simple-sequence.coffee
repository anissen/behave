Sequence = require("core/sequence")
TaskStatus = require("core/taskstatus")

class OutputTask
  constructor: (@text, @status = TaskStatus.SUCCESS) ->
  execute: ->
    print @text + ' [' + @status + ']'
    @status

root = new Sequence()
root.add new OutputTask 'Task 1'
root.add new OutputTask 'Task 2'
root.add new OutputTask 'Task 3', TaskStatus.FAILURE
root.add new OutputTask 'Task 4'
root.execute()
