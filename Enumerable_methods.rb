module Enumerable
  def my_each
    self.length.times do |n|
      if self.is_a?(Array)
        yield(self[n])
      end
    end
  end

  def my_each_with_index
    if self.is_a?(Array)
      self.length.times do |n|
        yield(self[n], n)
      end
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

  def my_all?
      check = true
      self.my_each do |n|
        if !yield(n)
          check = false
        end
        break if check == false
      end
    end

    def my_any?
        check = false
        self.my_each do |n|
          if yield(n)
            check = true
          end
          break if check == true
        end
      end

      def my_none?
          check = true
          self.my_each do |n|
            if yield(n)
              check = false
            end
            break if check == false
          end
        end

        def my_count
          counter = 0
          self.my_each do |n|
            if yield(n)
              counter += 1
            end
          end
          counter
        end

        def my_map
          new_array = Array.new
          self.my_each do |n|
              new_array.push(yield(n))
          end
          new_array
        end

        def my_inject(my_inject_arg = 0)
          self.my_each do |n|
            my_inject_arg = yield(my_inject_arg, n)
          end
          my_inject_arg
        end

end

include Enumerable


puts [1,2,3,4,5].inject { |x, y| x + y}
puts [1,2,3,4,5].my_inject { |x, y| x + y}
