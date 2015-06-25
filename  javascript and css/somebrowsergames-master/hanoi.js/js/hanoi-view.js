(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var disks = ['bottomHeight' ,  'middleHeight', 'topHeight'];

  var View = Hanoi.View = function(game, $el) {
    this.game = game;
    this.el = $el;
    this.firstTower = null;
    this.setupTowers();
  };

  View.prototype.setupTowers = function() {
    for (var i = 0; i < 3; i++) {
      var $tower = $('<div>').addClass('tower').attr('index', i);
      if (i ===0) {
          $tower.append($('<div>').addClass('fatDisk').addClass('bottomHeight').attr('size', 3));
          $tower.append($('<div>').addClass('midDisk').addClass('middleHeight').attr('size', 2));
          $tower.append($('<div>').addClass('smallDisk').addClass('topHeight').attr('size', 1));
      }
      $(this.el).append($tower);
    }
    this.render();
  };

  View.prototype.render = function () {
    var towers = this.game.towers;
    for (var i = 0; i < towers.length; i++){
      if ($('.tower').eq(i).length > 0){
        $('.tower').eq(i).empty();
      }
      for (var j = 0; j < towers[i].length; j++){
        if (towers[i][j] === 3){
          $('.tower').eq(i).append($('<div>').addClass('fatDisk').addClass(disks[j]).attr('size',3));
        }
        else if (towers[i][j] === 2){
          $('.tower').eq(i).append($('<div>').addClass('midDisk').addClass(disks[j]).attr('size',2));
        }
        else if (towers[i][j] === 1){
          $('.tower').eq(i).append($('<div>').addClass('smallDisk').addClass(disks[j]).attr('size',1));
        }
      }
    }
  };

  View.prototype.clickTower = function () {
    var that = this;
    $('.tower').click(function (event) {
      $(event.currentTarget).toggleClass('clicked');
      if (!that.firstTower) {
        that.firstTower = event.currentTarget.attributes[1].value;
      } else {
        var secondTower = event.currentTarget.attributes[1].value;
        if (that.game.move(that.firstTower, secondTower)) {
          that.render();
        } else {
          alert("Not a valid move!");
        }
        that.firstTower = null;
        $('.tower').removeClass('clicked');
        if (that.game.isWon()){
          $('.tower').off('click');
        }
      }
    });
  };
})();
