function range(start, end){
  var array = [start];
  if (start > end) {
    return [];
  }
  else if (start === end) {
    return array;
  }
  else {
    return array.concat(range(start + 1, end));
  }
}

console.log(range(5,10));

function sumArray(something){
  result = 0;
  for(var i=0;i<something.length;i++)
  {
    result += something[i];
  }
  return result;
}
function fancyRecursiveSumArray(something){
  if (something.length === 0){
    return 0;
  }
  result = something[0];
  return (result + fancyRecursiveSumArray(something.slice(1,something.length)));
}

console.log(fancyRecursiveSumArray([1,2,3,4]));

function fancyExponents(base, exp){
  if (exp === 0 ){
    return 1;
  }
  return (base * fancyExponents(base, exp-1));
}

console.log(fancyExponents(5,3));

function fibonacci(number){
  if (number <= 0){
    return [];
  }
  else if (number === 1){
    return [0];
  }
  else if (number === 2){
    return [0,1];
  }
  else{
    previousSequence = fibonacci(number - 1);
    new_num = previousSequence[previousSequence.length - 1] + previousSequence[previousSequence.length - 2];
    return previousSequence.concat(new_num);
  }
}

function fib_it(number) {
  newArray = [0, 1];
  if (number === 0) {
    return [];
  }
  else if (number === 1) {
    return [0];
  }
  else if (number === 2) {
    return [0, 1];
  }
  else {
    while (newArray.length < number) {
      newArray.push(newArray[newArray.length - 1] + newArray[newArray.length - 2]);
    }
  }

  return newArray;
}

console.log(fibonacci(10));
console.log(fib_it(10));


function bsearch(array, target) {
  if (array.length === 0){
    return null;
  }

  var midpoint = Math.floor(array.length / 2);
  var mid = array[midpoint];
  var left = array.slice(0, midpoint);
  var right = array.slice(midpoint + 1, array.length);

  if (target === mid) {
    return midpoint;
  }
  else if (target < mid) {
    return bsearch(left, target);
  }
  else if (target > mid) {
    subAnswer = bsearch(right, target);
    if (subAnswer === null){
      return nil;
    }
    else{
      return (midpoint + 1 + subAnswer);
    }
  }
}


console.log(bsearch([1,5,6,8,90,900,1000], 900));
