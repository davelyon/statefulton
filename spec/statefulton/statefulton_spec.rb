require 'spec_helper'

describe Statefulton::Statefulton do
  subject { Statefulton::Statefulton.new &block }

  describe "Domain Specific Language" do
    describe "#builder" do
      let(:block) { Proc.new { builder { Object.new} } }
      it "sets a builder with a block" do
        subject.builder.should be_an Object
      end
    end

    describe "#make" do
      let(:block) do
        Proc.new { make "one instance" }
      end
      it "defines a singleton method on this instance" do
        subject.should respond_to "one instance"
      end
    end

    describe "#only" do
      let(:block) do
        Proc.new do
          builder { Object.new }
          only "an instance"
        end
      end
      it "defines a singletone method on this instance" do
        subject.should respond_to "an instance"
      end
    end
  end

  describe "Internal API" do
    let(:block) do
      Proc.new do
        builder { Hash.new }
        make "one instance"
        only "that instance"
      end
    end

    describe "#build_instance" do
      context "first call" do
        it "builds the singular instance" do
          subject.send "one instance"
          subject.send(:instance).should be_a Hash
        end
      end

      context "subsquent call" do
        it "builds the singular instance" do
          subject.send "one instance"
          expect do
            subject.send "one instance"
          end.to raise_error "Instance already created!"
        end
      end
    end

    describe "#get_instace" do
      context "with an instance" do
        before { subject.send "one instance" }
        it "returns the singular instance" do
          subject.send("that instance").should be_a Hash
        end
      end

      context "with no instance" do
        it "raises an error" do
          expect do
            subject.send("that instance")
          end.to raise_error "No instance exists!"
        end
      end
    end
  end

end
