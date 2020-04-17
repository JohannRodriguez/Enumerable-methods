#spec/calculator_spec.rb
require './lib/enumerable_methods'

describe Enumerable do
  describe "#my_each" do
    it "iterates over each item of an array" do
      expect([11, 2, 3, 56].my_each { |x| x }).to eql([11, 2, 3, 56])
    end

    it "expecting enumerator if no block is given" do
      expect([11, 2, 3, 56].my_each).to be_kind_of(Enumerator)
    end
  end

  describe "#my_each_with_index" do
    it "iterates over each item and returns item with its index" do
      expect([11, 2, 3, 56].my_each_with_index { |n, i| [n, i] }).to eql([11, 0, 2, 1, 3, 2, 56, 3])
    end

    it "expecting enumerator if no block is given for the index" do
      expect([11, 2, 3, 56].my_each_with_index).to be_kind_of(Enumerator)
    end
  end
end
