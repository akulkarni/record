Record::Application.routes.draw do
  match 'api' => 'api#index'
  match 'api/register' => 'api#register'
  match 'api/receive_sms' => 'api#receive_sms'
  match 'api/send_nudge' => 'api#send_nudge_to_all_users'
  match 'api/send_ajay_nudge' => 'api#send_nudge_to_ajay'
end
