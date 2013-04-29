class FeedbackMailer < ActionMailer::Base
  default :from => 'noreply@yoursite.com'

  def feedback(feedback)
    @feedback = feedback
    mail(:to => 'jjliang84@gmail.com', :cc => 'diceydawg@gmail.com', :subject => 'Feedback for FoodWebBuilder')
  end
end
