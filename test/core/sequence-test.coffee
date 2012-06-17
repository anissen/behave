
Sequence      = require '../../src/core/sequence'
CallbackTask  = require '../../src/core/callbacktask'
TaskStatus    = require '../../src/core/taskstatus'

describe 'Sequence instance', ->

  it 'should be instationable without any arguments', ->
    (-> new Sequence).should.not.throw()

  it 'should be possible to add tasks', ->
    sequence = new Sequence
    sequence.tasks.length.should.equal 0
    sequence.add new CallbackTask (-> TaskStatus.SUCCESS)
    sequence.tasks.length.should.equal 1
    sequence.add new CallbackTask (-> TaskStatus.SUCCESS)
    sequence.tasks.length.should.equal 2

  it 'should return success if it only task and it succeeds', ->
    sequence = new Sequence
    sequence.add new CallbackTask (-> TaskStatus.SUCCESS)
    sequence.execute().should.equal TaskStatus.SUCCESS

  it 'should return failure if it only task and it fails', ->
    sequence = new Sequence
    sequence.add new CallbackTask (-> TaskStatus.FAILURE)
    sequence.execute().should.equal TaskStatus.FAILURE

  it 'should return running if it only task and it is running', ->
    sequence = new Sequence
    sequence.add new CallbackTask (-> TaskStatus.RUNNING)
    sequence.execute().should.equal TaskStatus.RUNNING

  it 'should return error if it only task and it fails with an error', ->
    sequence = new Sequence
    sequence.add new CallbackTask (-> TaskStatus.ERROR)
    sequence.execute().should.equal TaskStatus.ERROR

  it 'should succeed on only succeeding tasks', ->
    sequence = new Sequence
    sequence.add new CallbackTask (-> TaskStatus.SUCCESS)
    sequence.add new CallbackTask (-> TaskStatus.SUCCESS)
    sequence.execute().should.equal TaskStatus.SUCCESS

  it 'should not succeed when a task fails', ->
    sequence = new Sequence
    sequence.add new CallbackTask (-> TaskStatus.SUCCESS)
    sequence.add new CallbackTask (-> TaskStatus.FAILURE)
    sequence.add new CallbackTask (-> TaskStatus.SUCCESS)
    sequence.execute().should.equal TaskStatus.FAILURE