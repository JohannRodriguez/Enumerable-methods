module Enumerable
  def my_each
    length.times do |n|
      if is_a?(Array)
        yield(self[n])
      end
    end
  end

  def my_each_with_index
    if is_a?(Array)
      length.times do |n|
        yield(self[n], n)
      end
    end
  end

  def my_select
    if is_a?(Array)
      new_array = []
      my_each do |n|
        if yield(n)
          new_array.push(n)
        end
      end
    end
  end

  def my_all?
    check = true
    my_each do |n|
      if !yield(n)
        check = false
      end
      break if check == false
    end
    end

    def my_any?
      check = false
      my_each do |n|
        if yield(n)
          check = true
        end
        break if check == true
      end
    end

    def my_none?
      check = true
      my_each do |n|
        if yield(n)
          check = false
        end
        break if check == false
      end
    end

    def my_count
      counter = 0
      my_each do |n|
        if yield(n)
          counter += 1
        end
      end
      counter
    end

    def my_map(proc = nil)
      new_array = Array.new
      if proc == nil
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
        return result
    end

end

include Enumerable

def multiply_els(arr)
  arr.my_inject { |x, y| x * y}
end

puts multiply_els([2,4,5])

[1,2,3,4].each { |x| puts x}
[1,2,3,4].my_each { |x| puts x}
