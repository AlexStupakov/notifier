### README

# Email/SMS Notifier
Sends messages to user using templates and custom messages

## Deployment instructions
* Create config/database.yml
* Run ```bundle install```
* Setup database
```rake db:setup```
* Configure ```config.action_mailer.smtp_settings``` in config/environments/development|production
* Create application.yml with environment variables
```
gmail_username: 'user@gmail.com'
gmail_password: 'password' 
```
* Add twilio secrets to confif/secrets.yml
```yaml
twilio_account_sid:  <%= ENV.fetch("TWILIO_ACCOUNT_SID", "YOUR-TWILIO-SID-GOES-HERE") %>
twilio_auth_token:  <%= ENV.fetch("TWILIO_AUTH_TOKEN", "YOUR-TWILIO-AUTH-TOKEN-GOES-HERE") %>
twilio_phone_number:  <%= ENV.fetch("TWILIO_PHONE_NUMBER", "YOUR-TWILIO-TRIAL-PHONE-NUMBER-GOES-HERE") %>

```
* ```rails c```

## Creating user and message
```ruby
User.create(email: user@gmail.com, 
            phone: '+380689018304', 
            first_name: 'John', 
            last_name: 'Smith')
Message.create(template:"Hello, %first_name% %last_name%\nYour email: %email%\nYour phone: %phone%", 
               name: 'information')
```

## Send messages to user

```ruby
NotifierMailer.shared_email(User.first, Message.first).deliver_now
NotifierMailer.shared_email(User.first, Message.first).deliver_later
```
### Using customized message depended on message.name
```ruby
NotifierMailer.information_message(User.first).deliver_later
```
### Using Active Job
```ruby
SendEmailJob.set(wait: 20.seconds).perform_later(User.first, Message.first)
```

## Send SMS to user
```ruby
NotifierSms.call(User.first, Message.first)
```