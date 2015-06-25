var merge = function(left, right, comparator){
  var mergedArray = [];
  while (left.length > 0 && right.length > 0){
    if (comparator(left[0], right[0]) === -1){
      mergedArray.push(left.shift());
    }
    else{
      mergedArray.push(right.shift());
    }
  }
  return mergedArray.concat(left).concat(right);
}


Array.prototype.mergeSort = function(comparator) {
  if (this.length <= 1){
    return this;
  }
  var left = this.slice(0,Math.floor(this.length/2));
  var right = this.slice(Math.floor(this.length/2), this.length);
  return merge(left.mergeSort(comparator), right.mergeSort(comparator), comparator);
}

function lessThan(x,y){
  if (x < y){
    return -1;
  }
  else if (x === y){
    return 0;
  }
  else {
    return 1;
  }
}

console.log([1,2,56,2,1,516,167,1,5,2,37,6,6].mergeSort(lessThan));
