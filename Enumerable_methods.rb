module Enumerable
  def my_each
    self.length.times do |n|
      if self.is_a?(Array)
        yield(self[n])
      end
    end
  end

  def my_each_with_index
    self.length.times do |n|
      yield(self[n], n)
    end
  end

  def my_select
    if self.is_a?(Array)
      new_array = Array.new
      self.my_each do |n|
        if yield(n)
          new_array.push(n)
        end
      end
    end
  end
  
end



include Enumerable

# [1, 2, 3, 4, 5].select { |num| puts num.even? }

[1, 2, 3, 4, 5, 6, 7, 8, 9].my_select { |num| puts num.even? }
