class Device < ApplicationRecord
  validates :serial_number, :firmware_version, :auth_token, presence: true

  before_validation :ensure_auth_token, on: :create

  has_many :snapshots, class_name: 'DeviceSnapshot', dependent: :destroy

  def ensure_auth_token
    while auth_token.blank? || Device.where(auth_token: auth_token).any?
      self.auth_token = SecureRandom.hex
    end
  end
end
