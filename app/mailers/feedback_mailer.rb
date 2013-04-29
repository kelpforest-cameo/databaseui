class FeedbackMailer < ActionMailer::Base
  default :from => 'noreply@yoursite.com'

  def feedback(feedback)
    @feedback = feedback
    mail(:to => 'foodwebb@gmail.com', :subject => 'Feedback for FoodWebBuilder')
  end
end
