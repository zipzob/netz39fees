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

  def new_fee(fee)
    @fee = fee
    mail(to: CONFIG[:mailer_notify], subject: t(:mailer_new_fee))
  end

  def fee_changed(fee)
    @fee = fee
    mail(to: CONFIG[:mailer_notify], subject: t(:mailer_fee_changed))
  end
end
