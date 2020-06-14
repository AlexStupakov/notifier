class NotifierMailer < ApplicationMailer
  default from: "notifier@example.com"
  USER_FIELDS_TO_TEMPLATE = %w[first_name last_name email phone]

  # create customized emails for every Message
  # if a message name is 'information', creates #information_message
  # then you can use NotifierMailer.information_message.deliver_now for message with name 'information'
  Message.all.each do |message|
    define_method("#{message.name.underscore}_message") do |user|
      shared_email(user, message)
    end
  end

  def shared_email(user, message)
    @user = user
    @message_body = fill_template(message.template, USER_FIELDS_TO_TEMPLATE)
    puts "------------------------------------------------"
    puts @message_body
    puts "------------------------------------------------"
    mail(to: @user.email, subject: message.name, template_name: 'shared_email')
  end

  private
  def fill_template(template, fields_array)
    fields_array.each do |field|
      template.sub!("%#{field}%", @user.send(field))
    end
    template
  end
end
