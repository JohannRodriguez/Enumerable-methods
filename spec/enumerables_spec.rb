# spec/calculator_spec.rb
require './lib/enumerable_methods'

describe Enumerable do
  let(:test_array_numbers) { [11, 2, 3, 56] }
  let(:test_array_string) { %w[ant bear cat] }
  let(:test_range) { (1..4) }
  let(:test_array_bool) { [true, true, false, nil] }

  describe '#my_each' do
    it 'iterates over each item of an array' do
      expect(test_array_numbers.my_each { |x| x }).to eql([11, 2, 3, 56])
      expect(test_array_numbers.my_each).to be_kind_of(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'iterates over each item and returns item with its index' do
      expect(test_array_numbers.my_each_with_index { |n, i| [n, i] }).to eql([11, 0, 2, 1, 3, 2, 56, 3])
      expect(test_array_numbers.my_each_with_index).to be_kind_of(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns an array of selected items that pass a test' do
      expect(test_array_numbers.my_select(&:even?)).to eql([2, 56])
      expect(test_range.my_select(&:odd?)).to eql([1, 3])
      expect(test_array_numbers.my_select).to be_kind_of(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'returns true if all items in an array pass a test' do
      expect(test_array_string.my_all? { |word| word.length >= 3 }).to eql(true)
    end
    it 'returns true if all numbers in an array pass a test' do
      expect(test_array_numbers.my_all? { |i| i > 2 }).to eql(false)
    end
    it 'returns true if all numbers of a range pass a test' do
      expect(test_range.my_all? { |i| i < 5 }).to eql(true)
    end
    it 'returns true if all numbers of a range pass a test' do
      expect(test_array_bool.my_all?).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'returns true if any item in an array pass a given test' do
      expect(test_array_bool.my_any?).to eql(true)
    end
    it 'returns false if no value is given' do
      expect([].my_any?).to eql(false)
    end
    it 'return true if any item of the array is equal to argument' do
      expect(test_array_numbers.my_any?(11)).to eql(true)
    end
    it 'returns true if all items in an array pass a test' do
      expect(test_array_string.my_any? { |word| word.length >= 4 }).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'returns true if none of the items returns false in a given test' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
      expect(test_array_numbers.my_none?(String)).to eql(true)
      expect(test_range.my_none? { |i| (i + 2) > 5 }).to eql(false)
      expect(test_array_string.my_none?('bee')).to eql(true)
    end
    it 'returns true if all numbers of a range pass a test' do
      expect(test_array_bool.my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    it 'returns the number of items that return true for a given test' do
      expect(test_array_numbers.my_count { |x| x > 10 }).to eql(2)
      expect(test_array_string.my_count('ant')).to eql(1)
    end
  end

  describe '#my_map' do
    it 'returns an array of results of running a block with each item' do
      expect(test_range.my_map { |i| i * i }).to eql([1, 4, 9, 16])
      expect(test_array_numbers.my_map { |i| i * 2 }).to eql([22, 4, 6, 112])
      expect(test_array_string.my_map { |i| i.length }).to eql([3, 4, 3])
      expect(test_array_numbers.my_map).to be_kind_of(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'Combines all items by applying binary operation' do
      expect(test_range.inject { |sum, n| sum + n }).to eql(10)
      expect(test_array_numbers.inject(:*)).to eql(3696)
      expect(test_array_numbers.inject(2, :+)).to eql(74)
    end
  end
end
