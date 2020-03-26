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

  def my_all?
    check = true
    my_each do |n|
      check = false unless yield(n)
      break if check == false
    end
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

  def my_count
    counter = 0
    my_each do |n|
      counter += 1 if yield(n)
    end
    counter
  end

  def my_map(proc = nil)
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

  def my_inject
    result = self[0]
    shift
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

p [1, 2, 3, 4, 5].select { |num| num > 3 }  #should return [4, 5]
p [1, 2, 3, 4, 5].my_select { |num| num > 3 }  #should return [4, 5]
