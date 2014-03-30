
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
    for (var task of this.tasks) {
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
    for (var task of this.tasks) {
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
