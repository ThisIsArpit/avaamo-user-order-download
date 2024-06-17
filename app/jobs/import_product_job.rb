require 'csv'

class ImportProductJob 
    @queue = :order_detail_export
    BATCH_SIZE = 3

    def self.perform(products_data)
        error = []
        products_data.each_slice(GlobalConstant::BATCH_SIZE) do |batch|
          ActiveRecord::Base.transaction do
            batch.each do |product|
              data = {
                code: product[0],
                name: product[1],
                category: product[2]
              }
              Product.find_or_create_by!(data)
            end 
          end
         rescue => exception
            Rails.logger.info "Exception occurred - #{exception}"
            error << batch[batch.pluck(0).index(exception.message.split('-').last.strip)]
            batch.delete_at(batch.pluck(0).index(exception.message.split('-').last.strip))
            redo
        end
    end
end