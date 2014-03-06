
export class Task {
  constructor(name = 'Task') {
    console.log(name + ' created');
  }

  execute(callback) {
    callback('Cannot run execute on Task', false);
  }

  promiseExecute() {
    return (Promise.promisify(this.execute.bind(this)))();
  }

  toString() {
    return 'Task';
  }
}

export class SucceedingTask extends Task {
  constructor() {
    super('SucceedingTask');
  }

  execute(callback) {
    callback(null, true);
  }

  toString() {
    return 'SucceedingTask';
  }
}

export class FailingTask extends Task {
  constructor() {
    super('FailingTask');
  }

  execute(callback) {
    console.log('Failing... now!');
    callback('Burn to fail!', false);
  }

  toString() {
    return 'FailingTask';
  }
}

export class PrintTask extends Task {
  constructor(text = 'Hello World') {
    super('PrintTask');
    this.text = text;
  }

  execute(callback) {
    console.log('PrintTask: ' + this.text);
    callback(null, true);
  }

  toString() {
    return 'PrintTask';
  }
}

export class Sequence extends Task {
  constructor() {
    super('Sequence');
    this.tasks = [];
  }

  add(task) { // ...task
    this.tasks.push(task); // ...task
  }

  execute(callback) {
    this.tasks[0].execute(callback);
  }

  executeAll() {
    var me = this;
    return this.tasks.map(function(task) { return task.promiseExecute(); });
  }

  promiseExecuteAll() {
    return Promise.all(this.executeAll());
  }
}
