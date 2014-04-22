class PaymentNotification < ActiveRecord::Base	
  belongs_to :plan
  # serialize :params
  

  # attr_accessible :params, :plan_id, :status, :transasction_id

  # after_create :mark_plan_paid

  #     private

  #     def mark_plan_paid
  #       if status == 'Completed'
  #         plan.update_attribute(:paid, Time.now)
  #         UserMailer.welcome_email(subscription).deliver
  #       end
  #     end
end
