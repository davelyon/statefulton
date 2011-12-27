class Statefulton::Statefulton
  attr_reader :instance

  def initialize &block
    instance_eval &block
  end

  def builder &block
    @builder = block
  end

  def make string, &block
    define_singleton_method string do
      build_instance &block
    end
  end

  def expects string
    define_singleton_method string do
      instance or fail "No instance exists!"
    end
  end

  def reset!
    @instance = nil
  end

  private
  def build_instance &block
    fail "Instance already created!" unless @instance.nil?
    @instance = if block_given?
      block.call
    else
      @builder.call
    end
  end
end
