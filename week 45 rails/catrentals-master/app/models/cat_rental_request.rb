class CatRentalRequest < ActiveRecord::Base
  STATUS_OPTIONS = ["pending", "approved", "denied"]
  after_initialize :set_status
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUS_OPTIONS,
    message: "%{value} is not a valid status"}
  validate :overlapping_approved_requests

  belongs_to :cat

  def overlapping_requests(other_request)
    if self.cat_id == other_request.cat_id
      if other_request.end_date > self.start_date || self.end_date > other_request.start_date
        record.errors[:overlap] << 'Requests overlap'
      end
    end
  end

  def overlapping_approved_requests
    CatRentalRequest.all.reject {|item| item == self }.each do |other_request|
      if other_request.status == "approved" && self.status == "approved"
        overlapping_requests(other_request)
      end
    end
  end

  def set_status
    self.status ||= "pending"
  end
end
