require 'spec_helper'

describe Statefulton::Statefulton do
  let(:statefulton) { Statefulton::Statefulton.new &block }
  subject { statefulton }

  describe "Domain Specific Language" do
    describe "#builder" do
      let(:block) { Proc.new { builder { Object.new } } }
      it "sets a builder with a block" do
        subject.instance_variable_get("@builder").should be_a Proc
      end
    end

    describe "#make" do
      let(:block) do
        Proc.new { make "one instance" }
      end

      it "defines a singleton method on this instance" do
        subject.should respond_to "one instance"
      end

      context "with a block" do
        let(:block) do
          Proc.new do
            make "instance with stuff" do
              [1,2]
            end
          end
        end

        subject { statefulton.send("instance with stuff") }

        it "calls the block when activated" do
          subject.should == [1,2]
        end

        it "saves the state of the object" do
          subject.should == [1,2]
          statefulton.instance.should == [1,2]
        end

        it "raises if a creation attempt occurs" do
          expect do
            subject
            statefulton.send("instance with stuff")
          end.to raise_error(Statefulton::Exceptions::InstanceExists)
        end
      end
    end

    describe "#expects" do
      let(:block) do
        Proc.new do
          builder { Object.new }
          expects "an instance"
        end
      end

      it "defines a singleton method on this instance" do
        subject.should respond_to "an instance"
      end

      it "raises if no instance exists" do
        expect do
          subject.send("an instance")
        end.to raise_error(Statefulton::Exceptions::NoInstance)
      end
    end

    describe "#reset!" do
      let(:block) do
        Proc.new do
          builder { Hash.new }
          make "one"
        end
      end
      before { subject.send "one" }
      it "sets the instance to nil" do
        subject.reset!
        subject.instance.should be_nil
      end
    end
  end

  describe "Internal API" do
    let(:block) do
      Proc.new do
        builder { Hash.new }
        make "one instance"
        expects "that instance"
      end
    end

    describe "#build_instance" do
      context "first call" do
        it "builds the singular instance" do
          subject.send "one instance"
          subject.send(:instance).should be_a Hash
        end
      end

      context "with a block" do
        subject { Statefulton::Statefulton.new{} }
        it "calls the block instead of the builder" do
          subject.instance_eval do
            build_instance {:ok}.should == :ok
          end
        end
      end

      context "subsquent call" do
        it "builds the singular instance" do
          subject.send "one instance"
          expect do
            subject.send "one instance"
          end.to raise_error Statefulton::Exceptions::InstanceExists
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
          end.to raise_error(Statefulton::Exceptions::NoInstance)
        end
      end
    end
  end

end
