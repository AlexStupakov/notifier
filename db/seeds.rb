User.create(email: user@gmail.com, phone: '+380689018304', sms_gateway: 'sms.kyivstar.net', first_name: 'John', last_name: 'Smith')
Message.create(template:"Hello, %first_name% %last_name%\nYour email: %email%\nYour phone: %phone%", name: 'information')