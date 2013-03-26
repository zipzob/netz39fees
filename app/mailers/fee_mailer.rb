class FeeMailer < ActionMailer::Base
  default from: CONFIG[:mailer_from]

  def confirmation(fee)
    @fee = fee
    mail(to: fee.email, subject: t(:mailer_confirm))
  end

  def notification(fee)
    @fee = fee
    mail(to: fee.email, subject: t(:mailer_notify))
  end
end
