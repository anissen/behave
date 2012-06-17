
Task = require '../../src/core/task'

describe 'Task instance', ->  

  it 'should not be instantiable', ->
    (-> new Task).should.throw 'Task cannot be instantiated'
