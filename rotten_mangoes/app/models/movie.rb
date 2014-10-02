class Movie < ActiveRecord::Base

  mount_uploader :image, ImageUploader

  before_validation :add_duration_interval

  has_many :reviews

	validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :category,
    presence: true

  validates :release_date,
    presence: true

  # validate :release_date_is_in_the_future

  def review_average
      reviews.sum(:rating_out_of_ten)/reviews.size
  end

  def add_duration_interval
     if self.runtime_in_minutes < 90
      self.duration == "Less than 90"
      self.save
    elsif (self.runtime_in_minutes >= 90) && (self.runtime_in_minutes <= 120)
      self.duration == "Between 90 and 120"
      self.save
    elsif self.runtime_in_minutes > 120
      self.duration == "Greater than 120"
      self.save
    end
  end

  protected
  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
