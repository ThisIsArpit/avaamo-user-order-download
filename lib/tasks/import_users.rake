namespace :user do
    desc "Insert bulk user data into the database"
    task import: :environment do
        error = []
        users_data = CSV.read(GlobalConstant::USERS_CSV_FILE)
        # Resque.enqueue(ImportUserJob, users_data)
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
    end
end