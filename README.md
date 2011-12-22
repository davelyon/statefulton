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

To define a new statefulton:

	Statefulton(:hash) do
		builder { Hash.new }

		make "an" # Calling "an" will make on instance

		only "that" # Calling "that" will return the singular instance
	end

	StateOf(:hash, "an")   #build the object
	StateOf(:hash, "that") #get the object

Cucumber Usage:

	Transform /(an|that) hash/ do |state|
		StateOf(:hash, state)
	end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
