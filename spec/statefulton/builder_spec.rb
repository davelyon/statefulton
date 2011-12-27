require 'spec_helper'

describe Statefulton::Builder do
  subject { Statefulton::Builder.instance }
  after { subject.send(:initialize) }
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

  describe "#reset_all!" do
    before do
      subject.register(:one){}
      subject.register(:two){}
    end
    it "resets all known states" do
      subject.reset_all!.should be_true
    end
  end
end
