class DeviceSnapshotsController < APIController
  def create
    @device = Device.find_by!(auth_token: request.headers['Token'])

    snapshots = device_snapshots_params[:snapshots]

    if snapshots.size > 500
      head :bad_request
      return
    end

    DeviceSnapshot.transaction do
      @device_snapshots = snapshots.map do |attributes|
        snapshot = @device.snapshots.build(attributes)

        if snapshot.save
          snapshot.generate_issues
          next snapshot
        end

        render json: snapshot.errors, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end

      render :index, status: :created
    end
  end

  private

  def device_snapshots_params
    params.permit(snapshots: %i[taken_at temperature_celsius humidity_percentage carbon_monoxide_ppm status])
  end
end
