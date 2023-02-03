class Banner
  def initialize(message, width=message.size)
    @message = message
    @size = width
    @size < (@message.size + 2) ? @size = (@message.size + 2) : @size
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+" + "-" * (@size) + "+"
  end

  def empty_line
    "|" + " " * (@size) + "|"
  end

  def message_line
    "|" + "#{@message.center(@size)}" + "|"
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 10)
puts banner

banner = Banner.new('')
puts banner
