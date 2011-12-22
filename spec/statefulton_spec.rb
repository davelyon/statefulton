require 'spec_helper'

describe "Statefulton" do
  describe "Pretty API methods" do
    describe "Statefulton()" do
      it "returns a new statefulton" do
        Statefulton("a"){}.should be_a Statefulton::Statefulton
      end
    end

    describe "StateOf()" do
      before do
        Statefulton :foo do
          builder { Hash.new }
          make "an"
          only "the one"
        end
      end
      it "returns a statefultons instance" do
        StateOf(:foo, "an").should be_a Hash
        StateOf(:foo, "the one").should be_a Hash
      end
    end
  end
end
