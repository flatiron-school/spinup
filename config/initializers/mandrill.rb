ActionMailer::Base.smtp_settings = {
  :port           => 587,
  :address        => 'smtp.mandrillapp.com',
  :user_name      => ENV['MANDRILL_EMAIL'],
  :password       => ENV['MANDRILL_KEY'],
  :domain         => 'heroku.com',
  :authentication => :plain,
}

ActionMailer::Base.delivery_method = :smtp