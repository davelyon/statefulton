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

  def reset_all!
    states.values.map(&:reset!).none?
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
