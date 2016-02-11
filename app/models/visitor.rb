class Visitor < ActiveRecord::Base
  
  validates_presence_of :email, length: {minimum: 5}
  validates_presence_of :name, length: {minimum: 2}
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  after_create :subscribe
  
  def subscribe
    mailchimp = Gibbon::Request.new(api_key: Rails.application.secrets.mailchimp_api_key)
    list_id = Rails.application.secrets.mailchimp_list_id
    result = mailchimp.lists(list_id).members.create(
      body: {
        email_address: self.email,
        status: 'subscribed',
        merge_fields: {name: self.name}
      })
      Rails.logger.info("Subscribed #{self.email} to mailchimp") if result
  end
  
end
