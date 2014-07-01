# RuboCop::Git

RuboCop for git diff.

## Installation

Add this line to your application's Gemfile:

    gem 'rubocop-git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubocop-git

## Usage

    Usage: rubocop-git [options]
        -c, --config FILE                Specify configuration file
        -D, --display-cop-names          Display cop names in offense messages
            --cached                     git diff --cached
            --staged                     synonym of --cached
            --hound                      Hound compatibility mode (require rubocop 0.22.0)

## Contributing

1. Fork it ( https://github.com/m4i/rubocop-git/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
