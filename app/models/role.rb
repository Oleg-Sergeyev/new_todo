# frozen_string_literal: true

class Role < ApplicationRecord
  validates :name, :code, presence: true
  validates :name, length: { maximum: 300, minimum: 2 }
  validates :code, length: { maximum: 300, minimum: 2 }

  has_many :users, dependent: :nullify
end
