class EnvVar < ActiveRecord::Base
	validates_uniqueness_of :var
end
