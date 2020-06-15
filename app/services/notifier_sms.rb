module NotifierSms
  def self.call(user, message)
    message_body = Template.fill_template(message.template, user)
    puts "------------------------------------------------"
    puts message_body
    puts "------------------------------------------------"
    client = Twilio::REST::Client.new
    client.messages.create({
                               from: Rails.application.secrets.twilio_phone_number,
                               to: user.phone,
                               body: message_body
                           })
  end
end
