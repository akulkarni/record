class DailyQuestion < ActiveRecord::Base
  attr_accessible :message
  before_create :add_message

  def add_message
    write_attribute(:message, get_fresh_question)
  end
  
  def get_fresh_question
    r = DailyQuestion.order("id DESC").limit(15).select(:message)
    recent_questions = r.map { |q| q.message }
    return (QUESTIONS - recent_questions).sample 
  end

  QUESTIONS = [
               "Imagine today was a color. What color would it be?",
               "Today: good, bad, or ugly?",
               "If you were to relive today, what would you do differently?",
               "What was the most important thing you did today?",
               "What's your biggest regret of today?",
               "What conversation today do you remember the most?",
               "Who's someone that's close to you, but with whom you haven't spoken in a while? Call them.",
               "Are you happy? How do you know?",
               "What are you doing really poorly, that you could do better?",
               "What would 21 year old you say about your life today?",
               "30 years from now, when you look back on your life today, what would future you want to say to today you?",
               "Whose life did you impact the most today?",
               "Who had the most impact on your life today?",
               "What was the last nice thing you did for someone else?",
               "What do you value the most right now?",
               "Who is the most important person in your life?",
               "Where were you a year ago today? Where would you like to be a year from now?",
               "If you could wish something nice for someone else, what would you wish for, and for whom?",
               "What personal trait are you least happy about, want to improve?"
              ]

end
