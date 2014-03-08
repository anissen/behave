
(function(Behave) {
  Behave.plugins.dummyPlugin = function(deck) {
    deck.on('activate', function(e) {
      console.log('[dummyPlugin] deck activated!');
    });
  };
}(Behave));
