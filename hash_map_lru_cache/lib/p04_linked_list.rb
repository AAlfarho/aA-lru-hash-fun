class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = self.next
    @next.prev = self.prev
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next, @tail.prev = @tail, @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next unless empty?
  end

  def last
    @tail.prev unless empty?
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = get_node(key)
    if node.nil?
      nil
    else
      node.val
    end
  end

  def get_node(key)
    each {|node| return node if node.key == key}
    nil
  end

  def include?(key)
    each {|node| return true if node.key == key}
    false
  end

  def append(key, val)
    unless include?(key)
      new_node = Node.new(key, val)
      new_node.prev, new_node.next = @tail.prev, @tail
      @tail.prev.next = new_node
      @tail.prev = new_node
    end
  end

  def update(key, val)
    key = get_node(key)
    if key.nil?
      return nil
    else
      key.val = val
    end
  end

  def remove(key)
    key = get_node(key)
    if key.nil?
      return nil
    else
      key.remove
    end
  end

  def each(&prc)
    unless empty?
      node = first
      until node == @tail
        prc.call(node)
        node = node.next
      end
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
