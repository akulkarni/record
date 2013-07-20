class ApiController < ApplicationController

  # BIG TASKS
  # Text me every day at 8pm, with a varied message
  # Record the message and the response, encrypted
  # Send me an email on Sunday morning with my musings for that week
  # Also display messages on a page (?)

  # TODO
  # Allow user to see their encrypted and decrypted messages on web
  # Clean up login/review routes
  # Make it look pretty, especially on mobile use bootstrap? 
  # Send Sunday morning reflection email/sms (heroku scheduler?)


  def index
    render :text => 'OK'
  end

  def register
    name = params['name']
    email = params['email']
    phone_number = params['phone_number']
    password = params['password']

    unless name.blank? or email.blank? or phone_number.blank? or password.blank?
      user = User.new(:name => name,
                            :email => email,
                            :phone_number => '+%s' % phone_number,
                            :password => password)
      user.save
      if user
        send_welcome_sms(user)
        send_nudge([user], true)
      end
      response = 'SUCCESS!'
    else
      response = "Something's missing."
    end

    render :text => response
  end

  def send_nudge_to_all_users
    send_nudge(User.all, false)
    render :text => 'OK'
  end

  def send_nudge_to_ajay
    send_nudge([User.find_by_email('ajay@acoustik.org')], false)
    render :text => 'OK'
  end

  def receive_sms
    sms_body = params['Body']
    phone_number = params['From']

    user = User.where(:phone_number => phone_number).last unless phone_number.nil?
    user.add_record(sms_body) unless user.nil?

    render :text => 'OK'
  end

  def send_nudge(users, repeat_question)
    if repeat_question
      question = DailyQuestion.where("date(created_at) = '%s'" % DateTime.now.to_time.utc.to_s).last
      if question.nil?
        question = DailyQuestion.new
        question.save!
      end
    else
      question = DailyQuestion.new
      question.save!
    end
    
    users.each do |u|
      send_sms(u.phone_number, question.message)
    end
  end

  def send_sms(phone_number, text)
    client = get_twilio_client
    client.account.sms.messages.create(:from => ENV['RECORD_TWILIO_NUMBER'],
                                       :to => phone_number,
                                       :body => text[0...160])
  end

  WELCOME_MESSAGE = "Hi, %s! Welcome to Record, your private daily diary. You'll hear from us once a day. Want to unsubscribe? Uh, awkward... Let's just get started."
  def send_welcome_sms(user)
    send_sms(user.phone_number, WELCOME_MESSAGE % user.name)
  end

  def get_twilio_client
    return Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
  end

end
