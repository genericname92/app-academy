function subsets(array) {
  if (array.length <= 0) {
    return [[]];
  }
  var last = array.slice(array.length - 1, array.length);
  var subs = subsets(array.slice(0, array.length - 1));

  var newArray = [];
  for (var i = 0; i < subs.length; i++) {
    newArray.push(subs[i].concat(last));
  }

  subs = subs.concat(newArray);
  return subs;
}



console.log(subsets([1]));
console.log(subsets([1,2,3]));
