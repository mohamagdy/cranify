class Version < ActiveRecord::Base
  # Relations
  belongs_to :package
end
