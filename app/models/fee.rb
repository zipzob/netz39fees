class Fee < ActiveRecord::Base
  attr_accessible :donation, :fee, :name, :email, :activated
  validates :name, :email, :fee, presence: true, on: :create
  validates :email, format: { with: /\A[\w\.\-]+@[\w\-]+(.?[\w]+)+\z/ },
                    unless: Proc.new { |a| a.email.blank? },
                    on: :create
  validates :donation, numericality: true,
                       unless: Proc.new { |a| a.donation.blank? },
                       on: :create
  before_create :generate_activation_token
  after_save :send_activation_email
  
  private
  
  def generate_activation_token
    begin
      token = SecureRandom.urlsafe_base64
    end while Fee.where(activation_token: token).exists?
    self.activation_token = token
  end
  
  def send_activation_email
    FeeMailer.activation(self).deliver
  end
end
