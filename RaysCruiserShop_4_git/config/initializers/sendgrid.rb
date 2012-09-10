# Email service, currently running on a free account, need to either make it active or switch to a different service provider
ActionMailer::Base.smtp_settings = {
    :address => 'smtp.sendgrid.net',
    :port => 25,
    :authentication => :plain,
    :domain => 'rays-cruiser.com',
    :user_name => SiteConfig[:sendgrid][:username],
    :password => SiteConfig[:sendgrid][:password]
}

ActionMailer::Base.default_url_options[:host] = SiteConfig[:callback_host]