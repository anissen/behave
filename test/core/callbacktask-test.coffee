
CallbackTask = require '../../src/core/callbacktask'
TaskStatus = require '../../src/core/taskstatus'

describe 'CallbackTask instance', ->  
  callbackTask = null

  it 'should throw on instantiation without a constructor argument', ->
    (-> new CallbackTask).should.throw('callback function not set')

  it 'should throw on instantiation with invalid constructor argument', ->
    (-> new CallbackTask TaskStatus.SUCCESS).should.throw('callback function not set')

  it 'should not throw on instantiation with status argument', ->
    (-> new CallbackTask (-> TaskStatus.SUCCESS)).should.not.throw()

  it 'should return the assigned status', ->
    callbackTask = new CallbackTask (-> TaskStatus.SUCCESS)
    callbackTask.execute().should.equal TaskStatus.SUCCESS

    callbackTask = new CallbackTask (-> TaskStatus.FAILURE)
    callbackTask.execute().should.equal TaskStatus.FAILURE