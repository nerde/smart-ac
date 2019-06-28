class DeviceSnapshotsController < ApplicationController
  before_action :set_device_snapshot, only: [:show, :edit, :update, :destroy]

  def create
    @device = Device.find_by!(auth_token: request.headers['Token'])
    @device_snapshot = @device.snapshots.build(device_snapshot_params)

    if @device_snapshot.save
      render :show, status: :created
    else
      render json: @device_snapshot.errors, status: :unprocessable_entity
    end
  end

  private

  def device_snapshot_params
    params.permit(:taken_at, :temperature_celsius, :humidity_percentage, :carbon_monoxide_ppm, :status)
  end
end
