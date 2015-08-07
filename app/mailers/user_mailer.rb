class UserMailer < ApplicationMailer
  default from: "Hangman <mailgun@sandboxbcfb012dd95c4c1cb9a69438020e9e7f.mailgun.org>"

  def welcome_email(game)
    @game = game
    email_with_name = %("#{@game.host_name}" <#{@game.player_email}>)
    mail(to: email_with_name,
      subject: 'New Game Invitation',
      template_path: 'layouts',
      template_name: 'mailer.text.erb'
    )
  end
end
