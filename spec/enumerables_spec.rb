# spec/calculator_spec.rb
require './lib/enumerable_methods'

describe Enumerable do
  let(:test_array_numbers) { [11, 2, 3, 56] }
  let(:test_array_string) { %w[ant bear cat] }
  let(:test_range) { (1..4) }
  let(:test_array_bool) { [true, true, false, nil] }

  describe '#my_each' do
    it 'Iterates over each item of an array' do
      expect(test_array_numbers.my_each { |x| x }).to eql([11, 2, 3, 56])
    end
    it 'Expect enumerator when no block is given' do
      expect(test_array_numbers.my_each).to be_kind_of(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'Iterates over each item and returns item with its index' do
      expect(test_array_numbers.my_each_with_index { |n, i| [n, i] }).to eql([11, 0, 2, 1, 3, 2, 56, 3])
    end
    it 'Expect enumerator when no block is given' do
      expect(test_array_numbers.my_each_with_index).to be_kind_of(Enumerator)
    end
  end

  describe '#my_select' do
    it 'Returns an array of selected items if ther are even' do
      expect(test_array_numbers.my_select(&:even?)).to eql([2, 56])
    end
    it 'Returns an array of selected items if ther are odd' do
      expect(test_range.my_select(&:odd?)).to eql([1, 3])

    end
    it 'Expect enumerator when no block is given' do
      expect(test_array_numbers.my_select).to be_kind_of(Enumerator)

    end
  end

  describe '#my_all?' do
    it 'Returns true if all items have a length bigger than 3' do
      expect(test_array_string.my_all? { |word| word.length >= 3 }).to eql(true)
    end
    it 'Returns false if all numbers in an array are smaller than 2' do
      expect(test_array_numbers.my_all? { |i| i > 2 }).to eql(false)
    end
    it 'Returns true if all numbers of a range are smaller than 5' do
      expect(test_range.my_all? { |i| i < 5 }).to eql(true)
    end
    it 'Returns false if one of the items of the array is false or nill' do
      expect(test_array_bool.my_all?).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'Returns true if one of the items of the array is true' do
      expect(test_array_bool.my_any?).to eql(true)
    end
    it 'Returns false if no value is given' do
      expect([].my_any?).to eql(false)
    end
    it 'Returns true if any item of the array is equal to argument' do
      expect(test_array_numbers.my_any?(11)).to eql(true)
    end
    it 'Returns true if all items length in an array is bigger or equal than 4' do
      expect(test_array_string.my_any? { |word| word.length >= 4 }).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'Returns false if none of the items returns false in a given test' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end
    it 'Returns true if all items in the array are a String' do
      expect(test_array_numbers.my_none?(String)).to eql(true)
    end
    it 'Returns false in none of the items of the raenge plus two are bigger tham 5' do
      expect(test_range.my_none? { |i| (i + 2) > 5 }).to eql(false)
    end
    it 'Returns true if none of the itmes is equal to the argument' do
      expect(test_array_string.my_none?('bee')).to eql(true)
    end
    it 'Returns false if one of the items of the array is false or nill' do
      expect(test_array_bool.my_none?).to eql(false)
    end
  end

  describe '#my_count' do
    it 'Returns the number of items that return true for a given test' do
      expect(test_array_numbers.my_count { |x| x > 10 }).to eql(2)
    end
    it 'Returns the number of items that are equal to the argument' do
      expect(test_array_string.my_count('ant')).to eql(1)
    end
  end

  describe '#my_map' do
    it 'Returns an array of results of running a block with each item' do
      expect(test_range.my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end
    it 'Returns an array of results of running a block with each item times 2' do
      expect(test_array_numbers.my_map { |i| i * 2 }).to eql([22, 4, 6, 112])
    end
    it 'Returns an array of the length of each item in the array' do
      expect(test_array_string.my_map { |i| i.length }).to eql([3, 4, 3])
    end
    it 'Expect enumerator when no block is given' do
      expect(test_array_numbers.my_map).to be_kind_of(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'Combines all items by applying binary operation' do
      expect(test_range.inject { |sum, n| sum + n }).to eql(10)
    end
    it 'Combines all items by the argument operator' do
      expect(test_array_numbers.inject(:*)).to eql(3696)
    end
    it 'Combines all items including the number of the argumetn applying the argument operator' do
      expect(test_array_numbers.inject(2, :+)).to eql(74)
    end
  end
end
