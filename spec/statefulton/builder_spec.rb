require 'spec_helper'

describe Statefulton::Builder do
  subject { Statefulton::Builder.instance }
  describe "#register" do
    it "returns a new statefulton" do
      subject.register('a'){}.should be_a Statefulton::Statefulton
    end
  end

  describe "#get_state" do
    before do
      subject.register('hash'){
        builder { Hash.new }
        make "one"
      }.should be_a Statefulton::Statefulton
    end
    it "returns an object from a statefulton" do
      subject.get_state("hash", "one").should be_a Hash
    end
  end
end
