require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      @count += 1
      resize! if @count > num_buckets
      self[key.hash] << key
    end
  end

  def remove(key)
    if include?(key)
      @count -= 1
      self[key.hash].delete(key)
    end
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store.flatten
    @store = Array.new(temp.length * 2) { Array.new }
    temp.each do |n|
      self[n] << n
    end
  end
end
