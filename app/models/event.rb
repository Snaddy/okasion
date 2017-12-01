class Event < ActiveRecord::Base

	serialize :recurring, Hash 

    def recurring=(value)
        if RecurringSelect.is_valid_rule?(value)
            super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
        else
            super(nil)
        end
    end

	attr_accessor :hour, :minute, :meridiem, :endhour, :endminute, :endmeridiem

	validates_presence_of :title, :description, :address, :category, :time, :cover_image
	validates_length_of :title, maximum: 50
	validates_length_of :description, maximum: 1000
	validates_length_of :address, maximum: 100
	validates_length_of :url, maximum: 1000
	validates :endtime, presence: true, allow_blank: true
	validates :enddate, presence: true, allow_blank: true
  validates :date, presence: true, allow_blank: true

	belongs_to :user

	geocoded_by :address

	after_validation :geocode, :if => :address_changed?

	after_validation :found_address_presence

	before_validation :parse_time, :parse_endtime, :valid_date,
   :date_is_present, :smart_add_url_protocol, :valid_time

	mount_uploader :cover_image, CoverImageUploader

	def parse_time
    	if hour and minute and meridiem
   			self.time = DateTime.parse("#{hour}:#{minute}#{meridiem}") 
  		end
	end

	def parse_endtime
    	if endhour and endminute and endmeridiem
   			self.endtime = DateTime.parse("#{endhour}:#{endminute}#{endmeridiem}") 
  		else
  			self.endtime = nil
  		end
	end

	def found_address_presence
    	if latitude.blank? || longitude.blank?
      		self.errors.add(:address, :invalid, message: "Address is not valid")
    	end
  	end

  	def valid_date
     if date
  		if self.date < Date.today
  			self.errors.add(:date, "Date is in the past")
  		end
    end

  		if enddate
  			if self.enddate < self.date
  				self.errors.add(:enddate, "End date is before start date")
  			end
  		end
  	end

    def valid_time
      if endtime
        if endtime.strftime("%H%M") <= time.strftime("%H%M")
          self.errors.add(:endtime, "End time can't be before or the same as the start time")
        end
      end
    end

    def date_is_present
      if recurring.blank?
        if date.blank?
          self.errors.add(:date, "One time events must have a start date")
        end
      end
    end

    def smart_add_url_protocol
      if !url.blank?
        unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
          self.url = "http://#{self.url}"
        end
      end
    end

    #ice cube methods

    def rule
      IceCube::Rule.from_hash recurring 
    end 

    def schedule(start)
        schedule = IceCube::Schedule.new(start)
        schedule.add_recurrence_rule(rule)
        schedule
    end 

    def today(start)
      if recurring.empty?
        [self]
      else
          start_date = Date.today
          end_date = Date.today 
          schedule(start_date).occurrences(end_date).map do |date|
              Event.new(id: id, title: title, cover_image: cover_image)
          end
      end
    end

    #scopes for filters
    #scope :date, where(date: date)
    #scope :keywords, where("title like ? OR description = ?", "#{keywords}%", "#{keywords}%")}
    #scope :with_category, where(category: category)

end
