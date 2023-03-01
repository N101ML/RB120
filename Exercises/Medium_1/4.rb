require 'pry'

class CircularQueue
  def initialize(buffer_size)
    @queue = Array.new(buffer_size)
    @last = []
  end

  def enqueue(el)
    if @queue.any? { |element| element == nil }
      fill_nil(el)
    else
      dequeue
      fill_nil(el)
    end
    @last << el
  end

  def dequeue
    last = @last.shift
    idx = @queue.index(last)
    @queue[idx] = nil
    last
  end

  def fill_nil(random)
    temp = []
    @queue.each_with_index do |value, idx|
      if value == nil
        temp << idx
      end
    end
    @queue[temp.max] = random
  end

end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)


puts queue.dequeue == 2
queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)

puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
