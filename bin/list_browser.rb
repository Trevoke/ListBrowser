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

  def parent
    unless @node.send(@parent).nil?
      @node = @node.send(@parent)
    end
  end

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

  def leave
    # AND DON'T COME BACK!
  end

end