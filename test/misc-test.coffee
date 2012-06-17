
CallbackTask  = require '../src/core/callbacktask'
Sequence      = require '../src/core/sequence'
Selector      = require '../src/core/selector'
TaskStatus    = require '../src/core/taskstatus'

class RandomTask
  execute: ->
    return TaskStatus.SUCCESS if Math.random() < 0.5
    TaskStatus.FAILURE

class OutputTask
  constructor: (@text) ->
  execute: ->
    console.log @text
    TaskStatus.SUCCESS

class MaybeOutputSequence extends Sequence
  constructor: (text) ->
    super()
    @add new RandomTask
    @add new OutputTask(text)

describe 'Misc. classes', ->

  it 'should output something', ->
    root = new Sequence
    selector1 = new Selector
    selector1.add new MaybeOutputSequence('Hello')
    selector1.add new MaybeOutputSequence('Hey')
    selector1.add new OutputTask('Hi')
    selector2 = new Selector
    selector2.add new MaybeOutputSequence('cruel')
    selector2.add new MaybeOutputSequence('sweet')
    selector2.add new OutputTask('the')
    selector3 = new Selector
    selector3.add new MaybeOutputSequence('world')
    selector3.add new MaybeOutputSequence('Earth')
    selector3.add new OutputTask('planet')
    root.add new OutputTask('\n--------')
    root.add selector1
    root.add selector2
    root.add selector3
    root.add new OutputTask('--------')
    root.execute()