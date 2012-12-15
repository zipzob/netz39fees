class Fee < ActiveRecord::Base
  attr_accessible :donation, :fee, :name
  validates :name, :fee, presence: true, on: :create
end
