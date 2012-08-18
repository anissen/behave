
Task = require '../../src/core/task'

describe 'Task instance', ->  

  it 'should be instantiable', ->
    (-> new Task).should.not.throw 'Task can instantiated'
