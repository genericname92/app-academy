window.Pokedex = (window.Pokedex || {});
window.Pokedex.Models = {};
window.Pokedex.Collections = {};

Pokedex.Models.Pokemon = Backbone.Model.extend({
  "urlRoot": "/pokemon",
  "parse": function(resp){
    if (resp.toys){
      this.toys().set(resp.toys); //set takes in an array of objects and adds it to collection
      delete resp.toys; //so we work with the collection as opposed to a bunch of javascript objects
    }
    return resp;
  },
  "toys": function(){
    if (!this._toys){
      this._toys = new Pokedex.Collections.PokemonToys({pokemon: this}); //we can pass in the pokemon if we want to call toy.pokemon
    }
    return this._toys;
  }
});

Pokedex.Models.Toy = Backbone.Model.extend({
  "urlRoot": "/toys"
}); // WRITE ME IN PHASE 2

Pokedex.Collections.Pokemon = Backbone.Collection.extend({
  "url": "/pokemon",
  "model": Pokedex.Models.Pokemon
}); // WRITE ME

Pokedex.Collections.PokemonToys = Backbone.Collection.extend({
  // "url": "/pokemon" + pokemon.id,
  "model": Pokedex.Models.Toy
}); // WRITE ME IN PHASE 2

window.Pokedex.Test = {
  testShow: function (id) {
    var pokemon = new Pokedex.Models.Pokemon({ id: id });
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  },

  testIndex: function () {
    var pokemon = new Pokedex.Collections.Pokemon();
    pokemon.fetch({
      success: function () {
        console.log(pokemon.toJSON());
      }
    });
  }
};

window.Pokedex.RootView = function ($el) {
  this.$el = $el;
  this.pokes = new Pokedex.Collections.Pokemon();
  this.$pokeList = this.$el.find('.pokemon-list');
  this.$pokeDetail = this.$el.find('.pokemon-detail');
  this.$newPoke = this.$el.find('.new-pokemon');
  this.$toyDetail = this.$el.find('.toy-detail');

  // Click handlers go here.
  this.$pokeList.on("click", "li", this.selectPokemonFromList.bind(this));
  this.$newPoke.on("submit", this.submitPokemonForm.bind(this));
};

$(function() {
  var $rootEl = $('#pokedex');
	window.Pokedex.rootView = new Pokedex.RootView($rootEl);
  window.Pokedex.rootView.refreshPokemon();
});
