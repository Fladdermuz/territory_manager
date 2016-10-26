class Coordinate < ActiveRecord::Base
  belongs_to :territory
  belongs_to :zone
end
