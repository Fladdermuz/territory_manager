class TerritoryHistory < ActiveRecord::Base
  belongs_to :territory
  belongs_to :user
end
