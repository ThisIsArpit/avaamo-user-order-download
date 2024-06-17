module GlobalConstant
    env_constants = YAML.load_file(Rails.root.to_s + '/config/constants.yml')['constants']
    BATCH_SIZE = env_constants['batch_size']
    USERS_CSV_FILE = env_constants['users_csv_file']
    PRODUCTS_CSV_FILE = env_constants['products_csv_file']
    ORDER_DETAILS_CSV_FILE = env_constants['order_details_csv_file']
end