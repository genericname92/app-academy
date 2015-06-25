(function() {
  if (typeof SnakeGame === "undefined"){
    window.SnakeGame = {};
  }
  var DIRECTIONS = ["N", "E", "S", "W"];
  var MOVE_DIRECTIONS = [[-1,0], [0,1], [1,0], [0,-1]];

  SnakeGame.Snake = function() {
    this.dir = "N";
    this.segments = [5,5];
  };

  SnakeGame.Snake.prototype.move = function (){
    var coord = new Coord();
    for (var i = 0; i < DIRECTIONS.length; i++){
      if (DIRECTIONS[i] === this.dir){
        for (var j = 0; j < this.segments.length; j++){
          coord.plus(this.segments[j], MOVE_DIRECTIONS[i]);
        }
      }
    }
  };
  SnakeGame.Coord = function() {
  };

  SnakeGame.Coord.prototype.plus = function (c1, c2) {
    c1[0] += c2[0];
    c1[1] += c2[1];
  };

  SnakeGame.Coord.prototype.equals = function () {};

  SnakeGame.Coord.prototype.isOpposite = function () {};

  SnakeGame.Board = function() {
    this.snake = new Snake();
    this.grid = Array.new(9);
    for (var i = 0; i < this.grid.length; i++){
      this.grid[i] = [".",".",".",".",".",".",".",".","."];
    }
    this.grid[this.snake.segments[0]][this.snake.segments[1]] = "S";
  };

  SnakeGame.Board.prototype.render = function () {
    console.log(this.grid);
  };
})();
