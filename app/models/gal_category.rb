# GalCategory model
#
# Table name: gal_categories
# 
# id                 :integer         not null, primary key
# name               :string(50)      not null
# description        :string(255)
# permalink          :string(50)      not null, index, unique
# status             :integer
# 
class GalCategory < ActiveRecord::Base
  # Attributes
  attr_accessible :name, :description, :permalink, :status
  
  # Constats
  STATUS_INACTIVE  = 0
  STATUS_PUBLISHED = 1
  
  # Validations
  validates :name, :presence => true,
                   :length   => { :maximum => 50 }
  validates :description, :length => { :maximum => 255 }
  validates :permalink, :presence => true,
                        :length       => { :maximum => 50 },
                        :format       => { :with => /^[a-zA-Z0-9-]+$/ },
                        :uniqueness   => true
  validates :status, :presence => true
  
end
