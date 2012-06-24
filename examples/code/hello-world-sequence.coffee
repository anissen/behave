# Get the Sequence composite node
Sequence = require("core/sequence")
TaskStatus = require("core/taskstatus")

# A simple task for outputting text
class OutputTask
  constructor: (@text) ->
  execute: ->
    print @text
    TaskStatus.SUCCESS

# Create a new Sequence and add two OutputTasks as children
root = new Sequence()
root.add new OutputTask 'Hello'
root.add new OutputTask 'World'

# Execute the sequence and through it also its children
root.execute()