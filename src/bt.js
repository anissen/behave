
export class Task {
  constructor(name = 'Task') {
    // console.log(name + ' created');
  }

  execute() {
    throw new Error('Cannot run execute on Task');
    return false; //callback(false);
  }

  // promiseExecute() {
  //   return (Promise.promisify(this.execute.bind(this)))();
  // }

  toString() {
    return 'Task';
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

  toString() {
    return 'FunctionTask';
  }
}

export class PrintTask extends Task {
  constructor(text = 'Hello World') {
    super('PrintTask');
    this.text = text;
  }

  execute() {
    console.log('PrintTask: ' + this.text);
    return true; //callback(true);
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

  add(...task) {
    this.tasks.push(...task);
    return this;
  }

  execute() {
    // return Promise.reduce(this.tasks, function(result, task) {
    //   if (!result) return result;
    //   return task.promiseExecute();
    // }, true);

    return this.tasks.reduce(function(result, task) {
      if (!result) return result;
      return task.execute();
    }, true);
  }

  /*
  executeAll() {
    var me = this;
    return this.tasks.map(function(task) { return task.promiseExecute(); });
  }

  promiseExecuteAll() {
    return Promise.all(this.executeAll());
  }
  */
}

/*
export class Behave {
  constructor() {
    this.trees = [];
  }

  create() {
    return new BehaviorTree();
  }

  add(tree...) {
    this.trees.push(...tree);
  }

  update() {
    this.trees.forEach(tree => tree.execute(callback));
  }
}
*/

export class BehaviorTree extends Task {
  
}

