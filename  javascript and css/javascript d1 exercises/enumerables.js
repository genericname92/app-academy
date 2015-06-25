Array.prototype.myEach = function( theBlock ){
  for (var i = 0; i < this.length; i++){
    theBlock(this[i]);
  }
}

function double(something){
  console.log(something * 2);
}

[1,2,3].myEach(double);

Array.prototype.myMap = function( theBlock ){
  newArray = [];

  this.myEach( function(el) {
    newArray.push(theBlock(el));
  }
);
  return newArray;
}

function triple(something){
  return (something * 3);
}
console.log([1,2,3].myMap(triple));

Array.prototype.myInject = function( callback ){
  value = this[0];
  this.slice(1,this.length).myEach(
    function f(ele){
    value = callback(value, ele);
  }
  );


  return value;
}

function sum(x, y) {
  return (x + y);
}

console.log([1,2,3,4].myInject(sum));

Array.prototype.bubbleSort = function(){
  do
  {
    swapped = false;
    for(var i = 1; i < this.length; i++)
    {
      if (this[i-1] > this[i])
      {
        temp = this[i-1];
        this[i-1] = this[i];
        this[i] = temp;
        swapped = true;
      }
    }
  } while (swapped)

  return this;
}

console.log([3,2,5,6,2,323,0].bubbleSort());

var substrings = function(string) {
  var substrings = [];

  for(var i = 0; i < string.length; i++)
  {
    for(var j = i; j < string.length; j++)
    {
      substrings.push(string.slice(i, j + 1));
    }
  }
  return substrings;
}

console.log(substrings("cat"));
