def load_class(name)
  require_relative "../lib/puzzle"
  require_relative "../lib/puzzle/#{name.to_s}"
end
