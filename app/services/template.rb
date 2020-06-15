module Template
  USER_FIELDS_TO_TEMPLATE = %w[first_name last_name email phone]

  def self.fill_template(template, user)
    USER_FIELDS_TO_TEMPLATE.each do |field|
      template.sub!("%#{field}%", user.send(field))
    end
    template
  end
end