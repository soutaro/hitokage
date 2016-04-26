# Hitokage - Faster Float#to_s

The ruby's `Float#to_s` uses [David M. Gay's library](http://www.netlib.org/fp/dtoa.c).
The implementation is based on traditional DRAGON(1)(2), one of the most well known floating point printing algorithm developed by Guy L. Steel, et al.
I recently found another floating point printing library, [google/double-conversion](https://github.com/google/double-conversion), which implements faster algorithm called Grisu(3).

This is an example using the google/double-conversion for `Float#to_s`.

1. Guy L. Steel, Jr and Jon L. White, How to Print Floating-Point Acculately, PLDI '90, http://dl.acm.org/ft_gateway.cfm?id=93559
2. Robert G. Burger and R. Kent Dybvig, Printing Floating-Point Numbers Quickly and Acculately, PLDI '96, http://www.cs.indiana.edu/~dyb/pubs/FP-Printing-PLDI96.pdf
3. Florian Loitsch, Printing Floating-Point Numbers Quickly and Accurately with Integers, PLDI '10, http://www.cs.tufts.edu/~nr/cs257/archive/florian-loitsch/printf.pdf

### Benchmark

Grisu version is more than 4 times faster than DRAGON version, `Float#to_s`.

```
$ ruby -I lib test/benchmark.rb
🍉 Small float numbers, count=5000000, range=0.0...1.0
                           user     system      total        real
Float#to_s             4.500000   0.010000   4.510000 (  4.527218)
Float#hitokage_to_s    1.070000   0.000000   1.070000 (  1.083553)
Verifying results...👍

🍉 Usual float numbers, count=5000000, range=0.0...10000000.0
                           user     system      total        real
Float#to_s             4.650000   0.330000   4.980000 (  5.004367)
Float#hitokage_to_s    1.210000   0.140000   1.350000 (  1.364027)
Verifying results...👍

🍉 Big floats numbers, count=5000000, range=1.0e+20...1.0e+30
                           user     system      total        real
Float#to_s             6.050000   0.240000   6.290000 (  6.338893)
Float#hitokage_to_s    1.120000   0.000000   1.120000 (  1.132833)
Verifying results...👍
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hitokage'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hitokage

## Usage

It defines `Float#hitokage_to_s`.

```ruby
require 'hitokage'
1.0.hitokage_to_s
```

Or, you can replace the default `Float#to_s`.

```ruby
require 'hitokage/replace_float_to_s'
1.0.to_s
```

### Incompatibility

This library generates different string representation than `Float#to_s` for some values including `1e-10` and `1e10`.
However, the generated string can be converted to same float number using `to_f`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hitokage.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

The gem contains [google/double-conversion](https://github.com/google/double-conversion).
