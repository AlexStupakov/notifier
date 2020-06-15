# README

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
