function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function(){
  return (this.owner + " loves " + this.name);
}

var a = new Cat("bob", "the builder");
var b = new Cat("carl", "cat");

console.log(a.cuteStatement());
console.log(b.cuteStatement());


Cat.prototype.cuteStatement = function(){
  return ("Everyone loves " + this.name + "!");
}

console.log(a.cuteStatement());
console.log(b.cuteStatement());

Cat.prototype.meow = function(){
  console.log('meow');
}

a.meow();
b.meow();

a.meow = function(){
  console.log("roar");
}
a.meow();
b.meow();
