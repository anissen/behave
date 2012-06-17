
CompositeTask  = require '../../src/core/compositetask'
CallbackTask  = require '../../src/core/callbacktask'
TaskStatus    = require '../../src/core/taskstatus'

describe 'CompositeTask instance', ->

  it 'should be instationable without any arguments', ->
    (-> new CompositeTask).should.not.throw()

  it 'should be possible to add tasks', ->
    compositeTask = new CompositeTask
    compositeTask.tasks.length.should.equal 0
    compositeTask.add new CallbackTask (-> TaskStatus.SUCCESS)
    compositeTask.tasks.length.should.equal 1
    compositeTask.add new CallbackTask (-> TaskStatus.SUCCESS)
    compositeTask.tasks.length.should.equal 2

  it 'should throw an error on execute', ->
    compositeTask = new CompositeTask
    (-> compositeTask.execute()).should.throw()

  it 'should always return true on decide', ->
    compositeTask = new CompositeTask
    compositeTask.decide().should.be.true
    compositeTask.add new CallbackTask (-> TaskStatus.SUCCESS)
    compositeTask.decide().should.be.true