module Enumerable
  def my_each
    return to_enum unless block_given?

    length.times { |n| yield(n) }
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    length.times { |n| yield(self[n], n) }
    self
  end

  def my_select
    return to_enum unless block_given?

    new_array = []
    my_each { |n| new_array.push(n) if yield(n)}
    new_array
  end

  def my_all?(arg = nil)
    if arg.is_a?(Class)
      my_each { |n| return false unless n.is_a?(arg) }
    elsif arg.is_a?(String) || arg.is_a?(Integer)
      my_each { |n| return false unless n == arg }
    elsif arg != nil
      my_each { |n| return false unless n.match(arg) }
    elsif !block_given?
      my_each { |n| return false if n == false || n.nil? }
    else
      my_each { |n| return false unless yield(n) }
    end
    true
  end

  def my_any?(arg = nil)
    if arg.is_a?(Class)
      my_each { |n| return true if n.is_a?(arg) }
    elsif arg.is_a?(String) || arg.is_a?(Integer)
      my_each { |n| return true if n == arg }
    elsif arg != nil
      my_each { |n| return true if n.match(arg) }
    elsif !block_given?
      my_each { |n| return true unless n == false || n.nil? }
    else
      my_each { |n| return true if yield(n) }
    end
  false
  end

  def my_none?(arg = nil)
    if arg.is_a?(Class)
      my_each { |n| return false if n.is_a?(arg) }
    elsif arg.is_a?(String) || arg.is_a?(Integer)
      my_each { |n| return false if n == arg }
    elsif arg != nil
      my_each { |n| return false if n.match(arg) }
    elsif !block_given?
      my_each { |n| return false unless n == false || n.nil? }
    else
      my_each { |n| return false if yield(n) }
    end
    true
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
        counter
      end
      length
    end
    counter = 0
    my_each do |n|
      counter += 1 if yield(n)
    end
    counter
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    new_array = []
    if proc.nil?
      my_each { |n|   new_array.push(yield(n)) }
    else
      my_each { |n| new_array.push(proc.call(n)) }
    end
    new_array
  end

  def my_inject(arg = nil)
    result = self[0]
    result = arg unless arg.nil?
    shift if arg.nill?
    my_each { |n| result = yield(result, n) }
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |x, y| x * y }
end
