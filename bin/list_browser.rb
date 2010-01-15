# A class to browse tree structures.
# When creating the object, you have one required attribute and three optional
# attributes:
# node (the node where you wish to start browsing, usually the root of the tree)
#
# parent (the name of the method used to get to the parent)
#
# children (the name of the method used to get to the children)
#
# properties (the name of the method used to get to properties)
class ListBrowser

  attr_accessor :node, :parent, :children, :properties

  def initialize node, parent='parent', children='children', properties='properties'
    @node = node
    @parent = parent.to_sym
    @children = children.to_sym
    @properties = properties.to_sym
    puts @node.send(@properties)
    generate_menu
  end

  # Call this method to go to the current node's parent
  def parent
    unless @node.send(@parent).nil?
      @node = @node.send(@parent)
    end
  end

  # Call this method, with a number between 0 and the size of the array of
  # children -1 (if there are three children, between 0 and 2), to go to
  # the current node's child.
  def child number
    unless @node.send(@children).nil?
      @node = ( ( @node.send(@children) ).at(number) )
    end
  end

  private

  def generate_menu
    input = nil
    until ['q', 'Q'].include? input
      input = nil
      @menu = "Press Q to quit.\n"
      count = '1'
      @node.send(@children).each do 
        @menu << "#{count}. Go to child ##{count}.\n"
        count.succ!
      end
      @menu << "#{count}. Go to parent.\n"
      @menu << "#{count.succ}. Print current node's properties again.\n"

      choices = ['q', 'Q'] + ('1'..count.succ).to_a
      while !choices.include?(input)
        puts @menu
        input = gets.chomp
      end
      case input
        when 'q', 'Q'
          leave
        when count
          parent
        when count.succ
          puts @node.send(@properties)
        else
          child input.to_i - 1
      end
    end
  end

  def print_properties
    properties = @node.send(@properties)
    keylength = properties.max {|a, b| a.size }
    #valuelength = properties.max {|a, b| b.size}
    properties.each do |k, v|
      puts "#{k.ljust(keylength)} => #{v}"
    end
  end

  def leave
    # AND DON'T COME BACK!
  end

end