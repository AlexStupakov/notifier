class NotifierMailer < ApplicationMailer
  default from: "notifier@example.com"
  USER_FIELDS_TO_TEMPLATE = %w[first_name last_name email phone]

  def shared_email(user, message)
    @user = user
    @message_body = fill_template(message.template, USER_FIELDS_TO_TEMPLATE)
    mail(to: @user.email, subject: message.name)
  end

  private
  def fill_template(template, fields_array)
    fields_array.each do |field|
      template.sub!("%#{field}%", @user.send(field))
    end
    template
  end
end
