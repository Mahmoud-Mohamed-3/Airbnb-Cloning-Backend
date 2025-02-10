class UserMailer < ApplicationMailer
  default from: "no-reply@yourapp.com"

  def send_updates
    @user = params[:user]
    @property = params[:property]
    @owner = params[:owner]
    mail(to: @user.email, subject: "New Property Added")
  end
end
