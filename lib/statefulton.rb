require "statefulton/version"

module Statefulton
  module Exceptions
    class NoInstance     < StandardError; end
    class InstanceExists < StandardError; end
  end
  autoload :Builder,      'statefulton/builder'
  autoload :Statefulton,  'statefulton/statefulton'
  State = Builder.instance
  Reset = Class.new do
    define_singleton_method :all do
      Builder.instance.reset_all!
    end
  end

end

def Statefulton(name, &block)
  name = name.to_sym
  Statefulton::State.register name, &block
end

def StateOf(name, method)
  name = name.to_sym
  Statefulton::State.get_state name, method
end
