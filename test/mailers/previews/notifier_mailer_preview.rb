# Preview all emails at http://localhost:3000/rails/mailers/notifier_mailer
class NotifierMailerPreview < ActionMailer::Preview
  def shared_email_preview
    NotifierMailer.shared_email(User.first, Message.first)
  end
end
