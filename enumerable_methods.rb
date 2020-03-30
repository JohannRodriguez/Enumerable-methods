module Enumerable
  def my_each
    return to_enum unless block_given?

    length.times { |n| yield(self[n]) }
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
    my_each { |n| new_array.push(self[n]) if yield(self[n]) }
    new_array
  end

  def my_all?(arg = nil)
    if arg.is_a?(Class)
      my_each { |n| return false unless self[n].is_a?(arg) }
    elsif arg.is_a?(String) || arg.is_a?(Integer)
      my_each { |n| return false unless self[n] == arg }
    elsif !arg.nil?
      my_each { |n| return false unless self[n].match(arg) }
    elsif !block_given?
      my_each { |n| return false if self[n] == false || self[n].nil? }
    else
      my_each { |n| return false unless yield(self[n]) }
    end
    true
  end

  def my_any?(arg = nil)
    if arg.is_a?(Class)
      my_each { |n| return true if self[n].is_a?(arg) }
    elsif arg.is_a?(String) || arg.is_a?(Integer)
      my_each { |n| return true if self[n] == arg }
    elsif !arg.nil?
      my_each { |n| return true if self[n].match(arg) }
    elsif !block_given?
      my_each { |n| return true unless self[n] == false || self[n].nil? }
    else
      my_each { |n| return true if yield(self[n]) }
    end
    false
  end

  def my_none?(arg = nil)
    if arg.is_a?(Class)
      my_each { |n| return false if self[n].is_a?(arg) }
    elsif arg.is_a?(String) || arg.is_a?(Integer)
      my_each { |n| return false if self[n] == arg }
    elsif !arg.nil?
      my_each { |n| return false if self[n].match(arg) }
    elsif !block_given?
      my_each { |n| return false unless self[n] == false || self[n].nil? }
    else
      my_each { |n| return false if yield(self[n]) }
    end
    true
  end

  def my_count(arg = nil)
    unless block_given?
      counter = 0
      my_each { |n| counter += 1 if self[n] == arg }
      return counter unless arg.nil?

      return length
    end
    counter = 0
    my_each { |n| counter += 1 if yield(self[n]) }
    counter
  end

  def my_map(proc = nil)
    return to_enum unless block_given?

    new_array = []
    if proc.nil?
      my_each { |n| new_array.push(yield(self[n])) }
    else
      my_each { |n| new_array.push(proc.call(self[n])) }
    end
    new_array
  end

  def my_inject(result = 0, symbol = nil)
    symbol, result = result, symbol if result.is_a?(Symbol) and symbol.is_a?(Integer)
    symbol, result = result, 0 if result.is_a?(Symbol)
    new_array = to_a
    if !block_given?
      case symbol
      when :+
        new_array.length.times { |n| result += new_array[n] }
      when :*
        new_array.length.times { |n| result *= new_array[n] }
      when :/
        new_array.length.times { |n| result /= new_array[n] }
      when :-
        new_array.length.times { |n| result -= new_array[n] }
      when :**
        new_array.length.times { |n| result **= new_array[n] }
      when :%
        new_array.length.times { |n| result %= new_array[n] }
      end
      result
    else
      new_array.length.times { |n| result = yield(result, new_array[n]) }
    end
    result
  end
end

def multiply_els(arr)
  arr.my_inject { |x, y| x * y }
end


my_each_output = ''
my_each_output_two = ''
block = proc { |y| my_each_output += "Hello: #{y}" }
block_two = proc { |y| my_each_output_two += "Hello: #{y}" }
p [1,2,32,32,3,21,1,23,12].each(&block_two)
p [1,2,32,32,3,21,1,23,12].my_each(&block)
p my_each_output == my_each_output_two

p (1..5).my_inject(4) { |prod, n| prod * n }
