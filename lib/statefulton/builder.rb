require 'singleton'

class Statefulton::Builder
  include Singleton

  def register(name, &block)
    state = Statefulton::Statefulton.new &block
    add_state name, state
  end

  def get_state name, method
    states[name].public_method(method).call
  end

  private

  attr_reader :states

  def initialize
    @states = {}
  end

  def add_state name, state
    @states[name] = state
    state
  end
end

def Statefulton(name, &block)
  Statefulton::Builder.instance.register name, &block
end

def StateOf(name, method)
  Statefulton::Builder.instance.get_state name, method
end

=begin
class ObjectStateMachine
  def initialize name, &blk
    @name = name
    @instance_set = false
    instance_eval &blk
  end

  def make_many string, options={}, &block
    fail "Must provide a number of objects to build" unless options.has_key? :count
    define_singleton_method string do
      options[:count].times do
        collection << builder.call
      end
    end
  end

  def member string, options={}, &block
    fail "Must provide index" unless options.has_key? :index
    define_singleton_method string do
      collection[options[:index]]
    end
  end

  private

  def build_singular
    fail "Instance has already been set!" if @instance_set
    @singular = @builder.call
    @instance_set = true
  end

  def singular
    fail "No instance exists" unless @singular
    @singular
  end

  def collection
    @collection ||= []
  end

end

class Dummy
  def initialize
    puts "Created!"
  end

  def name
    "Hello!"
  end
end

thing = ObjectStateMachine.new(:project) do
  builder { Dummy.new }

  make "a"
  make "one"

  only "that"

  member "the first", index: 0
  member "the second", index: 1

  make_many "two", count: 2
end

thing.send("a")
puts thing.send("that").name
=end
