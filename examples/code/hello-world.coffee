# Get the TaskStatus for return values
TaskStatus = require("core/taskstatus")

# A simple task for outputting text
class OutputTask
  # Constructor taking a 'text' argument
  constructor: (@text) ->
  # The primary operation of the task
  execute: ->
    # Perform a simple text output
    print @text
    # Return a status value
    TaskStatus.SUCCESS

# Create a new instance of the task and supply argument
task = new OutputTask 'Hello World'

# Execute the primary operation of the task
task.execute()

# Note: 
# This example is very silly as
# a) The OutputTask is not a proper Behavior Tree task as it does not inheirit from a Behavior Tree task
# b) We invoke the execute() function directly and not through a Behavior Tree context
