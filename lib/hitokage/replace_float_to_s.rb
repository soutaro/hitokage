require "hitokage"

class Float
  alias_method :original_to_s, :to_s
  alias_method :to_s, :hitokage_to_s
end
