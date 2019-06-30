class DevicesController < APIController
  def show
    @device = Device.find(params[:id])
  end

  def create
    @device = Device.new(device_params)

    if @device.save
      render :show, status: :created
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  def index
    @devices = Device.page(params[:page])
    @devices = @devices.search(params[:query]) if params[:query].present?
  end

  private

  def device_params
    params.permit(:name, :serial_number, :firmware_version)
  end
end
