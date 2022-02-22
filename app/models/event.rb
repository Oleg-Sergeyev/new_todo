# frozen_string_literal: true

class Event < ApplicationRecord
  after_save :count_events
  after_destroy :recount_events

  validates :name, presence: true
  validates :name, length: { maximum: 500, minimum: 2 }

  belongs_to :user, counter_cache: true
  has_many :items, dependent: :destroy
  has_many :comments, as: :commentable
  # has_many :users, through: :commnets
  has_many :comentators, through: :comments, source: :user

  private

  def count_events
    user = User.where(id: user_id)
    if done
      user.limit(1).update(events_ffd_count: user.pluck(:events_ffd_count).first + 1)
    else
      user.limit(1).update(events_unffd_count: user.pluck(:events_unffd_count).first + 1)
    end
  end

  def recount_events
    user = User.where(id: user_id)
    if done
      user.limit(1).update(events_ffd_count: user.pluck(:events_ffd_count).first - 1)
    else
      user.limit(1).update(events_unffd_count: user.pluck(:events_unffd_count).first - 1)
    end
  end
end
