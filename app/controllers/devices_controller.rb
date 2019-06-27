class DevicesController < ApplicationController
  def create
    @device = Device.new(device_params)

    if @device.save
      render :show, status: :created
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  private

  def device_params
    params.permit(:name, :serial_number, :firmware_version, :auth_token)
  end
end
