class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates_length_of :description, minimum: 5
  validates :expire_at, inclusion: { in: (Date.today..Date.today+5.years) }
  enum status: %i[todo done]

  scope :q, ->(q) { where("title LIKE '%#{q}%'") unless q.blank? }
  scope :status, ->(status) { where(status: status) unless status.blank? }
  scope :expired, ->(val) { where("expire_at #{val == 'Expired' ? '<' : '>'} ?", Time.now) unless val.blank? }
  scope :by_title, ->(val) do
    if val == 'Asc'
      order(title: :asc) unless val.blank?
    elsif val == 'Desc'
      order(title: :desc) unless val.blank?
    end
  end
  scope :by_expire, ->(val) do
    if val == 'Asc'
      order(expire_at: :asc) unless val.blank?
    elsif val == 'Desc'
      order(expire_at: :desc) unless val.blank?
    end
  end
  scope :for_dashboard, ->(params) { q(params[:q])
                                                  .status(params[:status])
                                                  .expired(params[:expired])
                                                  .by_title(params[:by_title])
                                                  .by_expire(params[:by_expire])
                                                  .paginate(page: params[:page], per_page: 5)
                                                  }

end
