class Fee < ActiveRecord::Base
  attr_accessible :donation, :fee, :name, :email, :activated
  validates :name, :email, :fee, presence: true, on: :create
  validates :email, format: { with: /\A[\w\.\-]+@[\w\-]+(.?[\w]+)+\z/ },
                    unless: Proc.new { |a| a.email.blank? },
                    on: :create
  validates :donation, numericality: true,
                       unless: Proc.new { |a| a.donation.blank? },
                       on: :create
  before_create :generate_confirmation_token
  after_create :send_confirmation_email
  
  private
  
  def generate_confirmation_token
    begin
      token = SecureRandom.urlsafe_base64
    end while Fee.where(confirmation_token: token).exists?
    self.confirmation_token = token
  end
  
  def send_confirmation_email
    FeeMailer.confirmation(self).deliver
  end
end
