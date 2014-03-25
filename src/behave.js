
export var Behave = (function(moduleName, window) {
  var decks = [];
  var plugins = {};
  
  var createBehaviorTree = function(rootTask, selectedPlugins) {
    var listeners = {};

    var execute = function() {
      if (!fire('before_execute', this)) return;
      var result = rootTask.execute();
      fire('after_execute', this);
      return result;
    };

    var on = function(eventName, callback) {
      (listeners[eventName] || (listeners[eventName] = [])).push(callback);

      return function() {
        listeners[eventName] = listeners[eventName].filter(function(listener) {
          return listener !== callback;
        });
      };
    };

    var fire = function(eventName, eventData) {
      return (listeners[eventName] || []).reduce(function(notCancelled, callback) {
          return notCancelled && callback(eventData) !== false;
      }, true);
    };

    var deck = {
      on: on,
      fire: fire,
      execute: execute
    };

    for (var pluginName in selectedPlugins) {
      if (!plugins[pluginName]) {
        throw Error('Missing plugin: ' + moduleName + '-' + pluginName);
      }
      selectedPlugins[pluginName] !== false && plugins[pluginName](deck, selectedPlugins[pluginName]);
    }

    decks.push(deck);

    return deck;
  };

  var callOnAllDecks = function(method) {
    return function() {
      var args = arguments;
      return decks.map(function(deck) {
        return deck[method].apply(null, args);
      });
    };
  };

  var Behave = {
    create: createBehaviorTree,
    execute: callOnAllDecks('execute'),
    plugins: plugins
  };
  window[moduleName] = Behave;
  return Behave;
}('Behave', window));
