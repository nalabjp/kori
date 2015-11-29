# Kori

[![Gem Version](https://badge.fury.io/rb/kori.svg)](https://badge.fury.io/rb/kori)
[![Build Status](https://travis-ci.org/nalabjp/kori.svg?branch=master)](https://travis-ci.org/nalabjp/kori)
[![Test Coverage](https://codeclimate.com/github/nalabjp/kori/badges/coverage.svg)](https://codeclimate.com/github/nalabjp/kori/coverage)
[![Issue Count](https://codeclimate.com/github/nalabjp/kori/badges/issue_count.svg)](https://codeclimate.com/github/nalabjp/kori)
[![Dependency Status](https://gemnasium.com/nalabjp/kori.svg)](https://gemnasium.com/nalabjp/kori)

Kori generate deep frozen objects from yaml or hash.
It using a [ice_nine](https://github.com/dkubb/ice_nine), inspired by [Settingslogic](https://github.com/settingslogic/settingslogic).

Kori(kōri) means Ice in japanese.

## Installation

    $ gem install kori

## Usage

    require 'kori'

    # From Hash
    config = Kori.freeze({ a: 1, b: { c: 'abc' } })
    config.a                # 1
    config[:a]              # 1
    config['a']             # 1
    config.b                # { c: 'abc' }
    config.b.class          # Kori
    config.b.c              # 'abc'
    config.forzen?          # true
    config.a.frozen?        # true
    config.b.frozen?        # true
    config.b.c.frozen?      # true

    # From YAML
    config = Kori.freeze('app_config.yml')          # load from ./app_config.yml
    config = Kori.freeze('/path/to/app_config.yml') # load from /path/to/app_config.yml

    # If you are using Rails, it is possible to use as `Rails.application.config_for`
    config = Kori.freeze(:app_config)               # load from /rails_root/config/app_config.yml
    config = Kori.freeze('subdir/app_config')       # load from /rails_root/config/subdir/app_config.yml

## License

MIT License

see [LICENSE.txt](https://github.com/nalabjp/kori/blob/master/LICENSE.txt).

