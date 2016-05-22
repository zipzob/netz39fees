class Fee < ActiveRecord::Base
  attr_accessible :donation, :fee, :first_name, :last_name, :email, :confirmed, :iban, :bic, :bank_account_owner, :mandate_id, :mandate_date_of_signature

  validates :first_name, :last_name, :email, :iban, :bic, presence: true
  validates :email, format: { with: /\A[\w\.\-]+@[\w\-]+(.?[\w]+)+\z/ },
                    unless: Proc.new { |a| a.email.blank? },
                    on: :create
  validates :donation, numericality: true,
                       unless: Proc.new { |a| a.donation.blank? },
                       on: :create

  before_create :generate_confirmation_token
  before_save :normalize_iban
  before_save :normalize_bic

  def total
    self.fee + self.donation
  end

  def self.overall
    self.sum(:fee) + self.sum(:donation)
  end

  def name_on_transaction
    (bank_account_owner.blank?) ? "#{first_name} #{last_name}" : "#{bank_account_owner}"
  end

  private

  def normalize_iban
    self.iban = self.iban.gsub(' ', '')
  end

  def normalize_bic
    self.bic = self.bic.gsub(' ', '')
  end

  def generate_confirmation_token
    begin
      token = SecureRandom.urlsafe_base64
    end while Fee.where(confirmation_token: token).exists?
    self.confirmation_token = token
  end
end
