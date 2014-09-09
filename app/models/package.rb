class Package < ActiveRecord::Base
  # Relations
  has_many :versions
  has_many :mantainers
  has_many :authors
end
