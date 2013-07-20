class User < ActiveRecord::Base
  attr_accessible :email, :name, :phone_number, :username, :password
  attr_accessor :password
  validates :email, :uniqueness => true
  before_save :encrypt_password

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      return user
    else 
      return nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def add_record(message)
    user_id = read_attribute(:id)
    unless user_id.nil?
      latest_question = DailyQuestion.last
      record = DailyRecord.new(:user_id => user_id,
                               :plaintext_message => message,
                               :question_message => latest_question.message)
      record.save! 
    end
  end
end
