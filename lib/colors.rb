class String
  def bg(arg)
    return arg == 1 ? "\e[48;2;#{255};#{255};#{153}m#{self}\e[0m" : "\e[48;2;#{255};#{203};#{112}m#{self}\e[0m"
  end

  def blue
    return "\e[38;2;#{0};#{0};#{153}m#{self}\e[0m"
  end
  
  def red
    return "\e[38;2;#{204};#{0};#{0}m#{self}\e[0m"
  end
end
