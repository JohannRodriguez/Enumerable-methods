module Enumerable
  def my_each(each_count)
    each_count.length.times do |n|
      yield(each_count[n])
    end
  end
end

include Enumerable

[1, 2, 3].each { |x| puts "Current number #{x}"}

my_each_with_index([1, 2, 3, 4, 5, 6, 7, 8, 9]) { |x| puts "Current number #{x}"}
