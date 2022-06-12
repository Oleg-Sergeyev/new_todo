# frozen_string_literal: true

class Comment < ApplicationRecord
  after_save :count_comments
  after_destroy :recount_comments
  validates :content, presence: true
  validates :content, length: { maximum: 1000, minimum: 2 }

  belongs_to :user, counter_cache: true#, optional: true
  belongs_to :commentable, polymorphic: true

  #acts_as_nested_set

  #has_one :seos, as: :promoted

  # has_many :promoted_users,
  #          through: :seos,
  #          source: :promoted,
  #          source_type: :User

  # has_many :promoted_comments,
  #          through: :seos,
  #          source: :promoted,
  #          source_type: :Comment

  private

  def count_comments
    user = User.where(id: user_id)
    user.limit(1).update(comments_count: user.pluck(:comments_count).first + 1)
  end

  def recount_comments
    user = User.where(id: user_id)
    user.limit(1).update(comments_count: user.pluck(:comments_count).first - 1)
  end
end
