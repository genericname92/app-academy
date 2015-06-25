Array.prototype.myUniq = function(){
  if (this.length === 0){
    return this;
  }
  var newArray = [];
  for (var i = 0; i < this.length; i++)
  {
    flag = true;
    for (var j = 0; j < newArray.length; j++)
    {
      if (this[i] === newArray[j])
      {
        flag = false;
      }

    }
    if (flag){
      newArray.push(this[i]);
    }
  }
  return newArray;
}
console.log( [1,2,3,4,5,5,6,6,6,6,6,6].myUniq());


Array.prototype.twoSum = function() {
  var results = [];

  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        results.push([i, j]);
      }
    }
  }

  return results;
}

console.log([-1, 0, 2, -2, 1].twoSum());

Array.prototype.transpose = function() {
  var newArray = [];

  for (var row = 0; row < this.length; row++) {
    column = [];
    for (var col = 0; col < this.length; col++) {
      column.push( this[col][row]);
    }
    newArray.push(column);
  }

  return newArray;
};

var rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];


console.log(rows.transpose());
