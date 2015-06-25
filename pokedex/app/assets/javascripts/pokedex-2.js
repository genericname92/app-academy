Pokedex.RootView.prototype.addToyToList = function (toy) {
  return $('<li>').html("<a href=\"/#\">" + toy.escape("name") + "</a>")
  .attr("data-toy-id", toy.get("id"))
  .attr("data-pokemon-id", toy.get("pokemon_id"))
  .on("click", this.selectToyFromList.bind(this));
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  $('.toy-detail').empty();
  var that = this;
  var $ul= $("<ul>").addClass("toy-list");
  jQuery.each(toy.attributes, function(key, val) {
    if (key === "image_url"){
      $ul.prepend($('<img>').attr("src", val));
    } else {
      $ul.append($('<li>').text(key + ": " + val));
    }
  });
  var $select = $('<select>');
  this.pokes.fetch({
    success: function(){
      that.pokes.each (function(poke){
        $select.append("<option value=" + poke.get("id") + " >" + poke.get("name") + "</option>");
      });
    }
  });
  $ul.append($select);
  this.$toyDetail.append($ul);

};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  event.preventDefault();
  var currentId = $(event.currentTarget).data("toy-id");
  var pokemon = new Pokedex.Models.Pokemon ({id: $(event.currentTarget).data("pokemon-id")} );
  var that = this;
  pokemon.fetch({
    success: function () {
      that.renderToyDetail(pokemon.toys().get(currentId));
    }
  });
};
