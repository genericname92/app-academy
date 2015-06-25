Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var currentPokemon = new Pokedex.Models.Pokemon(attrs);
  var that = this;
  currentPokemon.save({}, {
    success: function (model) {
      that.addPokemonToList(model);
      that.pokes.add(model);
      callback(model);
    },
    error: function () {
      alert("Pokemon was not added to list");
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var pokemonAttrs = $(event.currentTarget).serializeJSON().pokemon;
  this.createPokemon(pokemonAttrs, this.renderPokemonDetail.bind(this));
};
