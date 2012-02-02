# Statefulton

A simple interface for the state of objects under test. Useful as an interface along with Cucumber Transforms.

## Installation

Add this line to your application's Gemfile:

    gem 'statefulton'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install statefulton

## Usage

Defined DSL methods:

* *builder* - Stores a block to use as a default builder method. Block is called when a 'make' method is triggered.
* *make*    - Creates a state method that returns a newly created instance of the object. Raises if called again.
* *expects* - Creates a state method that returns an existing instance of the object. Raises if no instance exists.

Accessing the state of something:

* StateOf(:name, "context")

Creating a statefulton:

* Statefulton(:name) { # a block of calls to the DSL methods }

Reset state between tests:

* Statefulton::Reset.all

To define a new statefulton:

	Statefulton(:user) do
	  builder { User.new }

	  make "an"

	  expects "that" # Calling "that" will return the singular instance
	end

	StateOf(:user, "that") #raise error: instance not created
	StateOf(:user, "an")   #build the object
	StateOf(:user, "an")   #raise error: instance already created
	StateOf(:user, "that") #get the object

Cucumber Usage:

	Given a user
	When I activate that user

	Transform /^(a|that) user$/ do |state|
	  StateOf(:user, state)
	end

	When /^I activate (that user)$/ do |user|
	  user.activate!
	end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (with tests!) (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
