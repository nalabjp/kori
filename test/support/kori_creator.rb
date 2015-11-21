class KoriCreator
  class << self
    def from_hash
      hash = {
        a: 1,
        'b' => 'xxx',
        c: [
          {
            d: 'yyy'
          },
          [
            2,
            '3'
          ]
        ],
        e: {
          f: {
            g: 'zzz'
          }
        },
        日本語: 'Key is no problem even in multi-byte string'
      }
      Kori.freeze(hash)
    end

    def from_yaml
      Kori.freeze(File.expand_path('../../fixtures/kori.yml', __FILE__))
    end

    def from_yaml_on_rails
      require File.expand_path('../../support/rails_helper.rb', __FILE__)

      Kori.stub_any_instance(:rails_config_path, File.expand_path('../../fixtures', __FILE__)) do
        Kori.freeze(:kori_on_rails)
      end
    ensure
      Object.class_eval { remove_const(:Rails) }
    end
  end
end

