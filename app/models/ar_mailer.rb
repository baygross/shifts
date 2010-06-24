require 'action_mailer/ar_mailer'

ActionMailer::Base.delivery_method = :activerecord
class ArMailer < ActionMailer::ARMailer
  self.delivery_method = :activerecord
# For use when users are imported from csv
  def new_user_password_instructions(user, dept)
    subject       "Password Creation Instructions"
    from          AppConfig.first.mailer_address
    recipients    user.email
    sent_on       Time.now
    body          :edit_new_user_password_url => edit_password_reset_url(user.perishable_token)
  end

  #  PAYFORM
  def due_payform_reminder(user, message, dept)
    subject     'Due Payform Reminder'
    recipients  "#{user.name} <#{user.email}>"
    from        "#{dept.department_config.mailer_address}"
    #reply_to    "#{admin_user.name} <#{admin_user.email}>"
    sent_on     Time.now
    body        :user => user, :message => message
  end

  def late_payform_warning(user, message, dept)
    subject     'Late Payforms Warning'
    recipients  "#{user.name} <#{user.email}>"
    from        "#{dept.department_config.mailer_address}"
    #reply_to    "#{admin_user.name} <#{admin_user.email}>"
    sent_on     Time.now
    body        :user => user, :message => message
  end

#creates a spreadsheet for an admin to see all of the printed payforms
  def printed_payforms_notification(admin_user, message, attachment_name)
    subject       'Printed Payforms ' + Date.today.strftime('%m/%d/%y')
    recipients    "#{admin_user.email}"
    from          'ST Payform Apps <studtech-st-dev-payform@mailman.yale.edu>'
    reply_to      'adam.bray@yale.edu'
    sent_on       Time.now
    content_type  'text/plain'
    body        :message => message
    attachment  :content_type => "application/pdf",
                :body         => File.read("data/payforms/" + attachment_name),
                :filename     => attachment_name
  end
# THIS DUPLICATES AN APP MAILER FUNCTION
# # Notifies a user when somebody else edits their payform
#   def admin_edit_notification(payform, payform_item, edit_item, dept)
#     user = payform.user
#     subject       'Your payform has been edited'
#     recipients    "#{user.name} <#{user.email}>"
#     from          dept.department_config.mailer_address
#     cc            User.find_by_login(edit_item.edited_by).email
#     sent_on       Time.now
#     content_type  'text/plain'
#     body          :payform => payform, :payform_item => payform_item, :edit_item => edit_item
#   end

  # SUB REQUEST:
  # email the specified list or default list of eligible takers
  def sub_created_notify(email_to, sub)

    subject     "[Sub Request] Sub needed for " + sub.shift.short_display
    recipients  email_to
    from        sub.user.email
    sent_on     Time.now
    body        :sub => sub
  end

end

