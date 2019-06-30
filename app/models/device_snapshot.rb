class DeviceSnapshot < ApplicationRecord
  belongs_to :device

  validates :taken_at, :temperature_celsius, :humidity_percentage, :carbon_monoxide_ppm, :status, presence: true

  has_many :issues, dependent: :destroy

  def generate_issues
    create_unique_issue('carbon_monoxide_over_limit') if carbon_monoxide_ppm > 9
    create_unique_issue(status) if %w[needs_service needs_new_filter gas_leak].include?(status)
  end

  private

  def create_unique_issue(kind)
    return if device.issues.unresolved.where(kind: kind).any?
    issues.create!(device: device, occurred_at: taken_at, kind: kind)
  end
end
