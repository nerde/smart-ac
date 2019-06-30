class Issue < ApplicationRecord
  belongs_to :device
  belongs_to :device_snapshot
  belongs_to :resolved_by, required: false, class_name: 'User'

  scope :unresolved, -> { where(resolved_at: nil) }
  scope :ordered, -> { order(resolved_at: :desc, occurred_at: :desc) }

  def resolved?
    resolved_at?
  end

  def resolve!(user)
    update!(resolved_at: Time.zone.now, resolved_by: user)
  end
end
