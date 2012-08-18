
Sequence      = require '../../src/core/sequence'
CallbackTask  = require '../../src/core/callbacktask'
Task  = require '../../src/core/task'
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

  it 'should return success if is has one task and it succeeds', ->
    sequence = new Sequence
    sequence.add new CallbackTask (-> TaskStatus.SUCCESS)
    sequence.execute().should.equal TaskStatus.SUCCESS

  it 'should return failure if it has one task and it fails', ->
    sequence = new Sequence
    sequence.add new CallbackTask (-> TaskStatus.FAILURE)
    sequence.execute().should.equal TaskStatus.FAILURE

  it 'should return running if it has one task and it is running', ->
    sequence = new Sequence
    sequence.add new CallbackTask (-> TaskStatus.RUNNING)
    sequence.execute().should.equal TaskStatus.RUNNING

  it 'should return error if it has one task and it fails with an error', ->
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

  it 'should return running until done, then return success', ->
    sequence = new Sequence
    sequence.add new CallbackTask -> 
      @count = 0 if not @count?
      @count++
      if @count <= 2
        return TaskStatus.RUNNING
      TaskStatus.SUCCESS
    sequence.execute().should.equal TaskStatus.RUNNING
    sequence.execute().should.equal TaskStatus.RUNNING
    sequence.execute().should.equal TaskStatus.SUCCESS

  it 'should return sdfsdfsdf running until done, then return success', ->
    sequence = new Sequence
    class CountTask extends Task
      constructor: (@count, @fun) ->
      execute: ->
        @count++
        @fun @count

    sequence.add new CountTask 0, (c) -> 
      if c <= 1
        return TaskStatus.RUNNING
      TaskStatus.SUCCESS

    sequence.add new CountTask 0, (c) -> 
      if c <= 1
        return TaskStatus.RUNNING
      TaskStatus.SUCCESS

    sequence.execute().should.equal TaskStatus.RUNNING
    #sequence.execute().should.equal TaskStatus.SUCCESS
    sequence.execute().should.equal TaskStatus.RUNNING
    sequence.execute().should.equal TaskStatus.SUCCESS
