class ApplicationMailer < ActionMailer::Base
  default from: "Hangman <mailgun@sandboxbcfb012dd95c4c1cb9a69438020e9e7f.mailgun.org>"
  layout 'mailer.text'
end
