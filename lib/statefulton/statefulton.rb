class Statefulton::Statefulton
  attr_reader :builder, :instance

  def initialize &block
    instance_eval &block
  end

  def builder &block
    @builder = block
  end

  def make string
    define_singleton_method string do
      build_instance
    end
  end

  def with string, &block
    raise "Block required!" unless block_given?
    define_singleton_method string do
      build_instance &block
    end
  end

  def only string
    define_singleton_method string do
      instance or fail "No instance exists!"
    end
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
