# GalAlbum model
#
# Table name: gal_albums
# 
# id                 :integer         not null, primary key
# gal_category_id    :integer
# name               :string(50)      not null
# description        :string(255)
# permalink          :string(50)      not null, index, unique
# status             :integer         default 0
#
class GalAlbum < ActiveRecord::Base
  # Attributes
  attr_accessible :gal_category_id, :name, :description, :permalink, :status
  
  # Constants
  STATUS_INACTIVE  = 0
  STATUS_PUBLISHED = 1
  
  # Validations
  validates :name, :presence   => true,
                   :length     => { :maximum => 50 },
                   :uniqueness => { :case_sensitive => false }
  validates :description, :length => { :maximum => 255 }
  validates :permalink, :presence     => true,
                        :length       => { :maximum => 50 },
                        :format       => { :with => /^[a-zA-Z0-9-]+$/ },
                        :uniqueness   => true
  validates :status, :presence => true
  
  # Relationships
  belongs_to :gal_category
  
  # Callbacks
  before_validation :set_permalink, :if => Proc.new{ |category| category.permalink.blank? && !category.name.blank? }
  
  private
    # set_permalink
    # gets the name and converts in a permalink
    #
    def set_permalink
      self.permalink = self.name.parameterize
    end
end
