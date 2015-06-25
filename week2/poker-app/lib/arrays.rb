class NonSquareArray < StandardError
end


class Array
  def my_uniq
    array = []
    self.each { |el| array << el unless array.include?(el) }
    array
  end

  def two_sum
    array = []
    self.each_with_index do |el, idx|
      self.drop(idx + 1).each_with_index do |el2, idx2|
        array << [idx, idx + idx2 + 1] if el + el2 == 0
      end
    end
    array
  end

end

def my_transpose(array)
  raise NonSquareArray.new if array.any? { |row| row.class != Array || row.length != array.length }
  output = Array.new(array.length) { Array.new(array.length) }
  (0...array.length).each do |y|
    (0...array[y].length).each do |x|
      output[y][x] = array[x][y]
    end
  end
  output
end

def stock_picker(array)
  high_score = 0
  output = []
  array.each_with_index do |el, idx|
    array.each_with_index do |el2, idx2|
      next if idx2 < idx
      if high_score < (el2 - el)
        high_score = el2 - el
        output = [idx, idx2]
      end
    end
  end
  output
end
