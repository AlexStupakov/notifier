class NotifierMailer < ApplicationMailer
  default from: "notifier@example.com"

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
    @message_body = Template.fill_template(message.template, @user)
    puts "------------------------------------------------"
    puts @message_body
    puts "------------------------------------------------"
    mail(to: @user.email, subject: message.name, template_name: 'shared_email')
  end
end
