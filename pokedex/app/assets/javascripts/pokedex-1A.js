Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $newPoke = $('<li>').addClass("poke-list-item")
    .html("<p>name: " + pokemon.escape("name") + "</p>" +
          "<p>type: " + pokemon.escape("poke_type") + "</p>")
    .attr("data-id", pokemon.get("id"));
  this.$pokeList.append($newPoke);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var that = this;
  this.pokes.fetch({
    success: function () {
      that.pokes.each(function (poke) {
        that.addPokemonToList(poke);
      });
    }
  });
};
