function messedUpChange(target, coins){
  var flag = true;
  for (var i = 0; i < coins.length; i++){
    if (coins[i] <= target){
      flag = false;
    }
  }
  return flag;
}

function makeChange(target, coins){
  if (target === 0){
    return [];
  }

  if (messedUpChange(target, coins)){
     return null;
  }
  var sortedCoins = coins.sort().reverse();
  var bestChange = null;

  for (var i = 0; i < coins.length; i++){
    if (coins[i] > target){
      continue;
    }
    var remainder = target - coins[i];

    var bestRemainder = makeChange(remainder, coins.slice(i, coins.length));

    if (bestRemainder === null) { continue; }

    thisChange = [coins[i]].concat(bestRemainder);

    if (bestChange === null || (thisChange.length < bestChange.length)) {
      bestChange = thisChange;
    }
  }

  return bestChange;
}


console.log(makeChange(34, [10, 7, 1]));
