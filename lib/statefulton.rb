require "statefulton/version"

module Statefulton
  autoload :Builder,      'statefulton/builder'
  autoload :Statefulton,  'statefulton/statefulton'
  State = Builder.instance
end


def Statefulton(name, &block)
  name = name.to_sym
  Statefulton::State.register name, &block
end

def StateOf(name, method)
  name = name.to_sym
  Statefulton::State.get_state name, method
end
