
export class Task {
  constructor(name = 'Task') {
    this.name = name;
  }

  execute() {
    throw new Error('Cannot run execute on Task');
    return false;
  }

  toString() {
    return this.name;
  }
}

export class FunctionTask extends Task {
  constructor(func) {
    super('FunctionTask');
    this.func = func;
  }

  execute() {
    return this.func();
  }
}

export class PrintTask extends Task {
  constructor(text = 'Hello World') {
    super('PrintTask');
    this.text = text;
  }

  execute() {
    console.log('PrintTask: ' + this.text);
    return true;
  }
}

export class Sequence extends Task {
  constructor() {
    super('Sequence');
    this.tasks = [];
    this.runningTask = null;
  }

  add(...task) {
    this.tasks.push(...task);
    return this;
  }

  execute() {
    for (var i = 0; i < this.tasks.length; i++) {
      var task = this.tasks[i];
      if (this.runningTask && task !== this.runningTask) continue;

      this.runningTask = null;
      var result = task.execute();
      if (result === undefined) this.runningTask = task;
      if (!result) return result;
    }
  }
}

export class Selector extends Task {
  constructor() {
    super('Selector');
    this.tasks = [];
    this.runningTask = null;
  }

  add(...task) {
    this.tasks.push(...task);
    return this;
  }

  execute() {
    for (var i = 0; i < this.tasks.length; i++) {
      var task = this.tasks[i];
      if (this.runningTask && task !== this.runningTask) continue;

      this.runningTask = null;
      var result = task.execute();
      if (result === undefined) this.runningTask = task;
      if (result) return result;
    }
  }
}

export class BehaviorTree extends Task {

}
