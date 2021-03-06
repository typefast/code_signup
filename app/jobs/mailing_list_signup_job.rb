class MailingListSignupJob < ActiveJob::Base
  
  def perform(user)
    logger.info "signing up #{user.email}"
    subscribe(user)
  end
  
  def subscribe(user)
    mailchimp = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
    list_id = Rails.application.secrets.mailchimp_list_id
    
    result = mailchimp.lists(list_id).members.create(
      body: {
        email_address: user.email,
        status: 'subscribed',
        merge_fields: {FNAME: user.name}
      })
     
      Rails.logger.info("Subscribed #{user.email} to mailchimp") if result
  end
  
end