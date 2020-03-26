module Enumerable
  def my_each
    length.times do |n|
      yield(self[n])
    end
    return if is_a?(Array)
  end

  def my_each_with_index
    length.times do |n|
      yield(self[n], n)
    end
    return if is_a?(Array)
  end

  def my_select
    new_array = []
    my_each do |n|
      new_array.push(n) if yield(n)
    end
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

[1, 2, 3, 4].each { |x| puts x }
[1, 2, 3, 4].my_each { |x| puts x }
