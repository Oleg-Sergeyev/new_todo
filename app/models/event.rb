# frozen_string_literal: true

class Event < ApplicationRecord
  include AASM

  after_save :count_events
  after_destroy :recount_events

  validates :name, presence: true
  validates :name, length: { maximum: 500, minimum: 2 }

  belongs_to :user, counter_cache: true
  has_many :items, dependent: :destroy
  has_many :comments, as: :commentable
  # has_many :users, through: :commnets
  has_many :comentators, through: :comments, source: :user
  has_many_attached :files #strict_loading: true

  aasm column: 'state' do
    state :created, initial: true, display: I18n.t('state.created')
    state :running, display: I18n.t('state.running')
    state :pending, display: I18n.t('state.pending')
    state :finished, display: I18n.t('state.finished')

    event :start do
      transitions from: %i[created pending], to: :running
    end

    event :pend do
      transitions from: %i[running created], to: :pending
    end

    event :complete do
      transitions from: :running, to: :finished
    end
  end

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
