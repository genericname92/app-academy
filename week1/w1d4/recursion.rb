#require 'byebug'

# #iterative method
# def range(start, ending_value)
#   start_index = start
#   result = []
#   until start_index == ending_value
#     result << start_index
#     start_index += 1
#   end
# end
def range(start, ending_value)
  return [] if start > ending_value
  result = [start] + range(start + 1, ending_value)
end

def exp1(number, exponent)
  return 1 if exponent == 0
  number * exp(number, exponent - 1)
end

def exp2(number, exponent)
  return 1 if exponent == 0
  if number.even?
    exp2(number, exponent / 2) * exp2(number, exponent / 2)
  else
    number * (exp2(number, (exponent - 1) / 2)) * (exp2(number, (exponent - 1) / 2))
  end
end

def deep_dup(array)
  return array if !array.is_a?(Array)
  array_copy = []
  array.each do |x|
    array_copy << deep_dup(x)
  end
  array_copy
end

def fibonacci_iterative(n)
  return [0]    if n == 1
  return [0, 1] if n == 2
  result = [0,1]

  (n-2).times do |i|
    result << (result[result.length - 2] + result[result.length - 1])
  end
  result
end

def fibonacci(n)
  return [0] if n == 1
  return [0, 1] if n == 2
  sequence = fibonacci(n - 1)
  sequence.push(sequence.last + sequence[-2])
end

def bsearch(arr, target)
  #base case find against single element
  return 0 if arr.count == 0
  if arr.count == 1
    if arr[0] == target
      return 0
    else
      return nil
    end
  end
  midpoint = arr.length / 2 #index

  left, right = arr[0...midpoint], arr[midpoint..-1]
  if left.last >= target
    result = bsearch(left, target)
    #byebug
    result
  else
    next_result = bsearch(right, target)
    result = midpoint + next_result unless next_result == nil
    #byebug
    result
  end
end

# #this is the partial solution for make change
# def make_change(change, coins)
#   return [] if change == 0
#   return nil if coins.count == 0 && change != 0
#
#   current_coin = coins.first
#   if change / current_coin >= 1
#     results = [current_coin] + make_change(change - current_coin, coins)
#   else
#     coins.shift
#     results = make_change(change, coins)
#   end
# end

def make_change(change, coins)
  return [] if change == 0
  return nil if coins.count == 0 && change != 0

  current_coin = coins.first
  if change / current_coin >= 1
    results = [current_coin] + make_change(change - current_coin, coins)
    next_results = make_change(change - current_coin, coins.shift)
    greedy_results = [current_coin] + next_results unless next_results == nil
    results = greedy_results if greedy_results.length < results.length  
  else
    coins.shift
    results = make_change(change, coins)
  end
end
