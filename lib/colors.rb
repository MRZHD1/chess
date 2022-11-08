class String
  def bg(arg)
    return arg == 0 ? "\e[48;2;#{163};#{105};#{46}m#{self}\e[0m" : "\e[48;2;#{252};#{204};#{116}m#{self}\e[0m"
  end

  def black
    return "\e[38;2;#{255};#{255};#{255}m#{self}\e[0m"
  end
  
  def white
    return "\e[38;2;#{0};#{0};#{0}m#{self}\e[0m"
  end
end