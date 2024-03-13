namespace :dev do

  DEFAULT_PASSWORD = 123456
  desc "Config development environment"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Delete DB...") { %x(rails db:drop) }
      show_spinner("Create DB...") { %x(rails db:create) }
      show_spinner("Migrate DB...") { %x(rails db:migrate) }
      show_spinner("Creating User default"){ %x(rails dev:add_user_default) }
      show_spinner("Creating Admin default"){ %x(rails dev:add_admin_default) }
    else
      puts "You are not in a development environment"
    end
  end

  private def show_spinner(msg_start, msg_end = "Concluded")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("#{msg_end}")
  end

  desc "Add User default"
  task add_user_default: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Add Admin default"
  task add_admin_default: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end


end
