module Enumerable
  def my_each(each_count)
    each_count.length.times do |n|
      yield(each_count[n])
    end
  end

  def my_each_with_index(each_with_index_count)
    each_with_index_count.length.times do |n|
      yield(each_with_index_count[n], n)
    end
  end

end

include Enumerable

[1, 2, 3].each_with_index { |x, y| puts "Current number #{x}, #{y}"}

my_each_with_index([1, 2, 3, 4, 5, 6, 7, 8, 9]) { |x, y| puts "Current number #{x}, #{y}"}
