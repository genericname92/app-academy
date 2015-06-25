Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  $('.detail').remove();
  var that = this;
  var $ul= $("<ul>").addClass("detail");
  jQuery.each(pokemon.attributes, function(key, val) {
    if (key === "image_url"){
      $ul.prepend($('<img>').attr("src", val));
    } else if (key === 'moves') {
      var moves = val.join(", ");
      $ul.append($('<li>').text(key + ": " + moves));
    } else {
      $ul.append($('<li>').text(key + ": " + val));
    }
  }
);
  pokemon.toys().forEach(function(toy) {
    $ul.append(that.addToyToList(toy));
  });

  this.$pokeDetail.append($ul);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var currentId = $(event.currentTarget).data("id");
  var pokemon = new Pokedex.Models.Pokemon( {id: currentId} );
  var that = this;
  pokemon.fetch({
    success: function () {
      that.renderPokemonDetail(pokemon);
    }
  });
};
