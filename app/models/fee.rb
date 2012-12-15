class Fee < ActiveRecord::Base
  attr_accessible :donation, :fee, :name
  validates :name, :fee, presence: true, on: :create
  validates :donation, numericality: true, unless: Proc.new { |a| a.donation.blank? }, on: :create
end
