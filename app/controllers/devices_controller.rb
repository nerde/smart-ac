class DevicesController < APIController
  include DaterangeParams

  before_action :authenticate_user!, only: %i[show index]

  def show
    @device = Device.find(params[:id])
    @last_snapshot = @device.snapshots.last

    @since = since_filter
    @upto = upto_filter
    @range = (@since..@upto)
    @snapshots = @device.snapshots.where(taken_at: @range)

    diff = @snapshots.pluck(Arel.sql('max(taken_at)'), Arel.sql('min(taken_at)')).first.compact.reduce(:-).to_i
    @period = case
              when diff > 120.days then :week
              when diff > 7.days then :day
              else :hour
              end
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
