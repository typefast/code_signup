class Visitor < ActiveRecord::Base
  
  validates_presence_of :email, length: {minimum: 5}
  validates_presence_of :name, length: {minimum: 2}
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  after_commit :subscribe
  
  def subscribe
    MailingListSignupJob.perform_later(self)
  end
  
end
