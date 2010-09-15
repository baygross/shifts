class Template < ActiveRecord::Base
	has_many :locations
	has_many :template_time_slots
	has_many :requested_shifts
	has_many :shift_preferences
	belongs_to :department
	has_and_belongs_to_many :roles
	
	validate :max_total_hours_greater_than_min
	validate :max_continuous_hours_greater_than_min
	validate :max_number_of_shifts_greater_than_min
	validate :max_hours_per_day_greater_than_continuous
  validate :feasibility_of_preferences
	validates_presence_of :roles
	validates_presence_of :locations
	
	accepts_nested_attributes_for :template_time_slots
	protected
	
	def max_hours_per_day_greater_than_continuous
		errors.add("Maximum hours per day is greater than maximum continuous hours") if (self.max_hours_per_day < self.max_continuous_hours)
	end
	
  def max_total_hours_greater_than_min
	  errors.add("Maximum hours is greater minimum total hours") if (self.max_total_hours < self.min_total_hours)
  end
  
  def max_continuous_hours_greater_than_min
    errors.add("Maximum hours is greater minimum continuous hours") if (self.max_continuous_hours < self.min_continuous_hours)
  end
  
  def max_number_of_shifts_greater_than_min
    errors.add("Maximum number of shifts is greater minimum number of shifts") if (self.max_number_of_shifts < self.min_number_of_shifts)
  end
  
  def feasibility_of_preferences
    errors.add("Signed up for enough hours (lower bound)") if ((self.max_continuous_hours*self.max_number_of_shifts < self.min_total_hours))
    errors.add("Signed up for enough hours (upper bound)") if ((self.min_continuous_hours*self.min_number_of_shifts > self.max_total_hours))
  end
  
end