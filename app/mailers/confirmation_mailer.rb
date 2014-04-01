class ConfirmationMailer < ActionMailer::Base
  default from: "confirmations@flatironschool.com"

  # USAGE

  # ConfirmationMailer.droplets_created(account).deliver
  
  # def droplets_created(current_account, user)
  #   @user = user
  #   @current_account = current_account
  #   @email = @current_account.email
  #   mail_builder("New Wishlist Has Been Created")
  # end

  # private

  #   def mail_builder(subject)
  #     mail(to: @email, from: COMPANY_EMAIL, subject: subject)
  #   end
end