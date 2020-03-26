module Enumerable
  def my_each
    return to_enum() unless block_given?
    length.times do |n|
      yield(self[n])
    end
    return self
  end

  def my_each_with_index
    return to_enum() unless block_given?
    length.times do |n|
      yield(self[n], n)
    end
    return self
  end

  def my_select
    return to_enum() unless block_given?
    new_array = []
    my_each do |n|
      new_array.push(n) if yield(n)
    end
    new_array
  end

  def my_all?(arg = nil)
    unless arg.nil?
      check = true
      if arg.is_a?(Integer)
        length.times do |n|
          if self[n] != arg
            check = false
            return false unless check
          end
        end
      else
        length.times do |n|
          unless self[n].is_a?(arg)
            check = false
            return false unless check
          end
        end
      end
      return true
    end
    unless block_given?
      check = true
      my_each do |n|
        if self[n].nil? || self[n] == false
          check = false
          return false unless check
        end
      end
      return true
    end
    check = true
    my_each do |n|
      check = false unless yield(n)
      return false unless check
    end
    return true
  end

  def my_any?
    check = false
    my_each do |n|
      check = true if yield(n)
      break if check == true
    end
  end

  def my_none?
    check = true
    my_each do |n|
      check = false if yield(n)
      break if check == false
    end
  end

  def my_count(arg = nil)
    unless block_given?
      counter = 0
      unless arg.nil?
        length.times do |n|
          if self[n] == arg
            counter += 1
          end
        end
        return counter
      end
      return length
    end
    counter = 0
    my_each do |n|
      counter += 1 if yield(n)
    end
    counter
  end

  def my_map(proc = nil)
    return to_enum() unless block_given?
    new_array = []
    if proc.nil?
      my_each do |n|
        new_array.push(yield(n))
      end
    else
      my_each do |n|
        new_array.push(proc.call(n))
      end
    end
    new_array
  end

  def my_inject(arg = 0)
    result = self[0]
    result = arg if arg != 0
    shift if arg == 0
    my_each do |n|
      result = yield(result, n)
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |x, y| x * y }
end

puts multiply_els([2, 4, 5])

p [1, 2, 3].my_all?(Integer)
p [1, 2, nil].my_all?(Integer)

p [3, 3, 3].my_all?(3)
p [3, 3, 1].my_all?(3)

# p [1, 2, 3].all? { |num| num < 4}   #should return true
# p [1, 2, 3].my_all? { |num| num < 4}
# p [1, 2, nil].all? #should return true
# p [1, 2, nil].my_all? #should return true
# p [1, false, nil].all? #should return false
# p [1, false, nil].my_all? #should return false
# p %w[dog door rod blade].my_all?(/d/) #should return true
# p [1, 2, 3].my_all?(3) #should return false
