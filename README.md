# Fakir

Fakir generates pseudo-random data.

Fakir::Random, a random number generator, can be defined to never return the same random number, or
to not return the same random number within N invocations. Thus one will not get the (random, but
appearing to not be) sequence of [ 1, 8, 3, 3, 3, 5, 2, 2 ], with repeating values (3 and 2).

Similarly, Fakir::Array wraps a Ruby Array, extending it with a `rand` method, which will not return
the same element during any sequences of calling `rand` (until `rand_reset` is called). Thus with
the array [ "apple", "banana", "cherry" ] one will not get the sequence [ "apple", "apple", "banana"
]. This functionality supports seeding data uniquely, such that two elements will not have the same
content.

Fakir::EmailAddress generates valid email addresses of several formats, using, by default, the
domain "example.com" (thus not actually using a possibly-taken email address). The domain can be
specified to a different value.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fakir'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fakir

## Usage

### Random numbers

    rnd = Fakir::Random.new 4, 2
    nums = 20.times.collect { rnd.rand }
    => [0, 2, 3, 1, 2, 1, 3, 0, 2, 3, 1, 2, 0, 3, 0, 1, 0, 3, 1, 3]

Note that there are no sequences of length 2 with repeated values.

    rnd = Fakir::Random.new 4, 3
    nums = 20.times.collect { rnd.rand }
    => [1, 0, 2, 1, 0, 2, 3, 0, 2, 3, 0, 2, 3, 0, 2, 1, 3, 2, 1, 0]

No sequences of length 3 have repeated values.

### Arrays

    ary = %w{ this is a test }
    fary = Fakir::Array.new ary
    4.times { |n| puts fary.rand }

Each of the elements in the original array will be returned, with none repeating.

    ary = %w{ this is a test }
    fary = Fakir::Array.new ary
    4.times { |n| puts fary.rand }
    fary.rand_reset
    4.times { |n| puts fary.rand }

After `rand_reset` is invoked, the contents of the wrapped array are reset and can be "consumed"
again.

### Email addresses

This generates email addresses based on the first and last names, using the default domain of
"example.com'. For "John Smith", a few examples: john.smith@example.com, jsmith@example.com,
jsmith9@example.com, jsmith17@example.com, smithj@example.com, smithj10@example.com, smithj88@example.com

## Contributing

1. Fork it ( https://github.com/jpace/fakir/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
