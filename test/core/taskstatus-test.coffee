
TaskStatus = require '../../src/core/taskstatus'
should = require 'should'

describe 'TaskStatus instance', ->  

  it 'should have four values', ->
    Object.keys(TaskStatus).length.should.equal 4

  it 'should have a "success" status', ->
    should.exist TaskStatus.SUCCESS
    TaskStatus.SUCCESS.should.equal 'success'

  it 'should have a "failure" status', ->
    should.exist TaskStatus.FAILURE
    TaskStatus.FAILURE.should.equal 'failure'

  it 'should have a "running" status', ->
    should.exist TaskStatus.RUNNING
    TaskStatus.RUNNING.should.equal 'running'

  it 'should have an "error" status', ->
    should.exist TaskStatus.ERROR
    TaskStatus.ERROR.should.equal 'error'