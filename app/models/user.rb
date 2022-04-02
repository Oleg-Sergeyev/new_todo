# frozen_string_literal: true

class User < ApplicationRecord
  include AASM
  include Rolable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # after_initialize :def_methods

  before_destroy :log_before_destroy
  after_destroy :log_after_destroy
  before_validation :normalize_name, on: :create
  before_validation :set_role, on: %i[create update]
  before_validation :normalize_email, if: proc { |u| u.email }

  validates :name, presence: true
  validates :name, length: { maximum: 50, minimum: 2 }
  validates :name, uniqueness: true

  belongs_to :role, inverse_of: :users
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :items, through: :events
  has_many :has_items, through: :events, source: :items

  has_many :commented_events,
           through: :comments,
           source: :commentable,
           source_type: :Event
  has_many :commented_users,
           through: :comments,
           source: :commentable,
           source_type: :User

  has_one :seos, as: :promoted

  has_one_attached :avatar

  aasm column: 'state' do
    state :created, display: I18n.t('state.created')
    state :active, initial: true, display: I18n.t('state.active')
    state :banned, display: I18n.t('state.banned')
    state :archived, display: I18n.t('state.archived')

    event :on do
      transitions from: %i[created banned], to: :active
    end

    event :off do
      transitions from: :active, to: :banned
    end

    event :remove do
      transitions from: %i[created banned], to: :archived
    end

    event :restore do
      transitions from: :archived, to: :banned
    end
  end

  # def def_methods
  #   Role.find_each do |role|
  #     User.define_method "#{role.code}?" do
  #       role_id == role.id
  #     end
  #   end
  # end

  act_as_rolable

  before_save :ensure_authentication_token

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end 

  def attributes
    { name: name, email: email }
  end

  def description
    "#{name} (#{email})"
  end

  def active_for_authentication?
    super && active?
  end

  # def admin?
  #   Role.where(code: 'admin')&.ids.include? role_id
  # end

  # def default?
  #   Role.where(code: 'default')&.ids.include? role_id
  # end

  private

  def normalize_email
    self.email = email.downcase
  end

  def set_role
    self.role ||= Role.find_by(code: :default)
  end

  def normalize_name
    self.name = name.downcase if name # .titleize
  end

  def log_before_destroy
    Rails.logger.info '#######################################'
    Rails.logger.info "Собираемся удалить пользователя #{name}"
    Rails.logger.info '#######################################'
  end

  def log_after_destroy
    Rails.logger.info '#######################################'
    Rails.logger.info "Пользователь #{name} удален"
    Rails.logger.info '#######################################'
  end
end
