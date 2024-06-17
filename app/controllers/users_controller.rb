
class UsersController < ApplicationController
  def index
    @users = User.all.order(id: 'asc')
  end

  def export
    Resque.enqueue(ExportOrderDetailJob, params[:id])
    @users = User.all.order(id: 'asc')
    redirect_to users_path(@users), notice: 'Your download has been queued.'
  end

  def download    
    csv_files = Dir.glob(File.join("tmp", '*.csv'))
    latest_csv_file = csv_files.max_by { |file| File.ctime(file) }
    Rails.logger.info "Latest  - #{latest_csv_file}"
    file_path = Rails.root.join(latest_csv_file)
    Rails.logger.info "Downloading start - #{file_path}"

    if File.exist?(file_path)
      send_file(file_path, filename: 'order_details.csv', type: 'text/csv')
    else
      redirect_to users_path, alert: 'File is not ready yet. Please try again in a moment.'
    end
  end

end
