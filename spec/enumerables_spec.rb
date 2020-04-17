# spec/calculator_spec.rb
require './lib/enumerable_methods'

describe Enumerable do
  describe '#my_each' do
    it 'iterates over each item of an array' do
      expect([11, 2, 3, 56].my_each { |x| x }).to eql([11, 2, 3, 56])
    end

    it 'expecting enumerator if no block is given' do
      expect([11, 2, 3, 56].my_each).to be_kind_of(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'iterates over each item and returns item with its index' do
      expect([11, 2, 3, 56].my_each_with_index { |n, i| [n, i] }).to eql([11, 0, 2, 1, 3, 2, 56, 3])
    end

    it 'expecting enumerator if no block is given for the index' do
      expect([11, 2, 3, 56].my_each_with_index).to be_kind_of(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns an array of selected items that pass a test' do
      expect([1, 2, 3, 4, 5].my_select(&:even?)).to eql([2, 4])
    end
  end

  describe '#my_all?' do
    it 'returns true if all items in an array pass a test' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if any item in an array pass a given test' do
      expect([nil, true, 99].my_any?).to eql(true)
    end
    it 'returns false if no value is given' do
      expect([].my_any?).to eql(false)
    end
  end
end
