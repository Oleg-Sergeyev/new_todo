# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { maximum: 1000, minimum: 2 }

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_one :seos, as: :promoted

  # has_many :promoted_users,
  #          through: :seos,
  #          source: :promoted,
  #          source_type: :User

  # has_many :promoted_comments,
  #          through: :seos,
  #          source: :promoted,
  #          source_type: :Comment
end
