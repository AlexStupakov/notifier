class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(user, message)
    @user, @message = user, message
    NotifierMailer.shared_email(@user, @message).deliver_later
  end
end
