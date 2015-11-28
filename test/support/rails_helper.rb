module Rails
  extend self

  def env
    'test'
  end

  def application
    MockApp
  end

  module MockApp
    extend self

    def paths
      { 'config' => MockPath }
    end
  end

  module MockPath
    extend self

    def existent
      [ File.expand_path('../../fixtures', __FILE__) ]
    end
  end
end
