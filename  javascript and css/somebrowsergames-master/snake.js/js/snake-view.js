(function(){
  if (typeof SnakeGame === 'undefined'){
    window.SnakeGame = {};
  }
  var DIRECTIONS = ["N", "E", "S", "W"];
  SnakeGame.View = function($el) {
    this.$el = $el;
    this.board = new Board();
    this.$el.on('keydown', this.handleKeyEvent);
  }

  SnakeGame.View.prototype.handleKeyEvent = function(event) {
    if (event.keyCode == 119) {
      this.board.snake.dir = DIRECTIONS[0];
    }
  }

})();
