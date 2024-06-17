require 'csv'

class ExportOrderDetailJob 
    @queue = :order_detail_export

    def self.perform(user_id)
        attributes = %w{user_name user_email product_code product_name product_category order_date}
        csv_data = CSV.generate(headers: true) do |csv|
          csv << attributes
          User.find(user_id).order_details.find_each(batch_size: GlobalConstant::BATCH_SIZE) do |data|
              csv << [
                data.user.user_name,
                data.user.email,
                data.product.code,
                data.product.name,
                data.product.category,
                data.order_date.to_date
              ]
          end
        end
        file_path = Rails.root.join('tmp', "order-details-#{Time.now.to_i}.csv")
        File.write(file_path, csv_data)
        ActionCable.server.broadcast "export_order_detail_channel", { message: 'export_done', file_path: file_path.to_s }
      end
  end

  
  