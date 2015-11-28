require 'erb'
require 'yaml'
require 'ice_nine'

class Kori < Hash
  private_class_method :new

  class << self
    def freeze(file_or_hash)
      IceNine.deep_freeze(new(file_or_hash))
    end
    alias :create :freeze

    undef_method :[]
  end

  def get(key)
    parts = key.split('.')
    curs = self
    while p = parts.shift
      curs = curs.__send__(p)
    end
    curs
  end

  def [](key)
    fetch(key, nil)
  end

  def fetch(*args)
    arity = args.size
    raise ArgumentError, "invalid number of elements (#{arity} for 1..2)" unless arity.between?(1, 2)

    key, val = args
    if respond_to?(key.to_s)
      __send__(key.to_s)
    elsif arity == 2
      val
    else
      raise KeyError, "key '#{key}' not found"
    end
  end

  private

  def initialize(file_or_hash)
    case file_or_hash
    when Hash
      replace(file_or_hash)
    when String, Symbol
      replace(load_yaml(file_or_hash))
    else
      raise "Could not load configuration. No such file - #{file_or_hash}"
    end

    create_accessors!
  end

  def load_yaml(file)
    on_rails = !!defined?(Rails)

    file = "#{rails_config_path}/#{file}.yml" if on_rails
    file = file.to_s.concat('.yml') if file.is_a?(Symbol)

    config = YAML.load(ERB.new(File.read(file)).result)
    config = config[Rails.env] if on_rails
    config
  end

  def rails_config_path
    Rails.application.paths['config'].existent.first
  end

  def create_accessors!
    self.each do |key, val|
      value = type_cast_if_hash(val)
      create_accessor_for(key, value)
    end
  end

  def create_accessor_for(key, val)
    instance_variable_set("@#{key}", val)
    self.class.class_eval <<-EOCODE, __FILE__, __LINE__ + 1
      def #{key}
        @#{key}
      end
    EOCODE
  end

  def type_cast_if_hash(value)
    if value.is_a?(Hash)
      self.class.__send__(:new, value)
    elsif value.is_a?(Array)
      value.map { |item| type_cast_if_hash(item) }
    else
      value
    end
  end
end
