require 'csv'

class ImportUserJob 
    @queue = :order_detail_export

    def self.perform(users_data)
        error = []
        users_data.each_slice(GlobalConstant::BATCH_SIZE) do |batch|
            ActiveRecord::Base.transaction do
              batch.each do |user|
                data = {
                  user_name: user[0],
                  email: user[1],
                  phone: user[2]
                }
                User.find_or_create_by!(data)
              end 
            end
           rescue => exception
              Rails.logger.info "Exception occurred - #{exception}"
              error << batch[batch.pluck(0).index(exception.message.split('-').last.strip)]
              batch.delete_at(batch.pluck(0).index(exception.message.split('-').last.strip))
              redo
        end
        file_path = Rails.root.join('tmp', "order-details-#{Time.now.to_i}.csv")
        File.write(file_path, csv_data)
        ActionCable.server.broadcast "export_order_detail_channel", { message: 'export_done', file_path: file_path.to_s }
    end
end

  
  