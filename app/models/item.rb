# frozen_string_literal: true

class Item < ApplicationRecord
  after_save :count_items
  after_destroy :recount_items

  validates :name, presence: true
  validates :name, length: { maximum: 2000, minimum: 5 }

  belongs_to :event, touch: true, dependent: :destroy
  #has_one :has_user, through: :event#, source: :user, dependent: :destroy
  has_one :has_user, through: :event, source: :user

  private

  def count_items
    user = User.where(id: Event.where(id: event_id).pluck(:user_id).first)
    if done
      user.limit(1).update(items_ffd_count: user.pluck(:items_ffd_count).first + 1)
    else
      user.limit(1).update(items_unffd_count: user.pluck(:items_unffd_count).first + 1)
    end
  end

  def recount_items
    user = User.where(id: Event.where(id: event_id).pluck(:user_id).first)
    if done
      user.limit(1).update(items_ffd_count: user.pluck(:items_ffd_count).first - 1)
    else
      user.limit(1).update(items_unffd_count: user.pluck(:items_unffd_count).first - 1)
    end
  end
end
