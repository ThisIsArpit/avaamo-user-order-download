require 'csv'

namespace :order_detail do
    desc "Insert bulk product data into the database"
    task import: :environment do
        order_details_data = CSV.read(GlobalConstant::ORDER_DETAILS_CSV_FILE)
        # Resque.enqueue(ImportOrderDetailJob, order_details_data)
        order_details_data.each_slice(GlobalConstant::BATCH_SIZE).with_index do |batch,index|
          ActiveRecord::Base.transaction do
            batch.each do |detail|
              user = User.find_by!(email: detail[0])
              product = Product.find_by!(code: detail[1])
              data = {
                user: user,
                product: product,
                order_date: detail[2]
              }
              OrderDetail.find_or_create_by!(data)
            end 
          end
          rescue => exception
            Rails.logger.info "Exception occurred - #{exception}"
            Rails.logger.info "Error between - #{order_details_data[index]} ... #{order_details_data[batch.length]}"
        end
    end
end