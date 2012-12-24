class FeeMailer < ActionMailer::Base
  default from: "kontakt@netz39.de"
  
  def activation(fee)
    @fee = fee
    mail(to: fee.email, subject: "Fee activation")
  end
end
