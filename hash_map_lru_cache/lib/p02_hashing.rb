require 'prime'
PRIMES = Prime.first 100

class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    step_one = map(&:hash)
    step_two = step_one.map.with_index do |el, idx|
      el * PRIMES[idx]
    end
    step_two.reduce { |acc, el| el^acc }.hash
  end
end

class String
  def hash
    str = self.dup
    (str.chars.map(&:ord).hash * PRIMES[str.length]).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    h = self.dup.sort
    (h.hash * PRIMES[h.length % 3]).hash
  end
end
