require 'mail'

class MailSender
  attr_accessor :mail

  def initialize(arr)
    config = YAML.load_file("mail_config.yml")
    @mail = Mail.new do arr
            from "from@example.com"
            to config["mail_to"]
            subject arr["title"]
            test = <<EOS
            <p>#{arr["event_url"]}</p>
            <p>#{arr["description"]}</p>
EOS
            html_part do
              body test
            end
          end
     @mail.delivery_method :smtp, {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => "smtp.gmail.com",
      :user_name            => config["mail_username"],
      :password             => config["mail_password"]
     }
   end

  def send
    mail.deliver!
  end
end