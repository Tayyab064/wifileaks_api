module EnvironmentVariable
  class Application < Rails::Application
    config.before_configuration do
    	  EnvVar.all.each do |en|
	          ENV["#{en.var}"] = en.val
	      end
    end # end config.before_configuration
  end # end class
end # end module