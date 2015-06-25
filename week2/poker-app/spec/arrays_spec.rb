require 'arrays'

describe "Array#my_uniq" do
  it "Removes duplicate elements" do
    expect([1,2,3,1,2,3].my_uniq).to eq([1,2,3])
  end
end

describe "Array#two_sum" do
  it "Returns indices which elements add to zero" do
    expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
  end

  it "Returns indices in order" do
    expect([-3, 3, 3].two_sum).to eq([[0, 1], [0, 2]])
  end
end

describe "#my_transpose" do
  it "Transposes the elements in a 2D array" do
    expect(my_transpose([
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
        ])).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
  end

  it "Should raise error for non-square array" do
    expect{ my_transpose([0, 1]) }.to raise_error(NonSquareArray)
  end
end

describe "#stock_picker" do
  it "Should not return same day" do
    expect(stock_picker([4, 1, 2, 3, 4])).to_not eq([0, 0])
  end

  it "Should output the most profitable day" do
    expect(stock_picker([0, 1, 2, 3, 4])).to eq([0, 4])
  end

  it "Sell day should not be before buy day" do
    expect(stock_picker([4, 1, 2, 3, 0])).to_not eq([0, 4])
  end

  it "Does not return days if no profitable sells" do
    expect(stock_picker([4, 3, 2, 1, 0])).to eq([])
  end
end
