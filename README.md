# README

# INITIALIZATION
    Ruby version - 2.7.2
    Rails version - 6.1.7.8
    Mysql version - 8.3.0
    Redis version - 7.2.5

# DATABASE 
    MySql database has been added as the database support.
    Its configurations has been add in database.yml file. Please change accordingly.
    Please run the below command to create db -
    * rails db:create 

# DB Migration
    Create table migration script has been added for - User, Product and OrderDetail.
    Please run the below command to create tables -
    * rails db:migrate

# SEED DATA
    Rake tasks to import User, Product and OrderDetail have been added in lib/tasks location.
    Corresponding csv format data file resides in the same location.
    In order to seed data into the db table please run below command -
    * rake product:import
    * rake user:import
    * rake order_detail:import

# RESQUE, REDIS AND ACTION-CABLE
    I have used Resque and Redis for background jobs.
    Corresponding job has been added in app/jobs location.
    Please run below command to start resque worker - 
    * QUEUE =* rake resque:work

    Action-cable has been implemented for web socket communication.

# EXECUTION

    1. Install the gems specified in Gemfile - 
        * bundle install

    2. Start mysql server -
        * mysql.server start

    3. Create database -
        * rails db:create

    4. Migration -  
        * rails db:migrate

    5. Seed data - Run rake task
        * rake product:import
        * rake user:import
        * rake order_detail:import

    6. Start redis server
        * redis-server
    
    7. Start resque worker
        * QUEUE=* rake resque:work
    
    8. Start rails server
        * rails server
    
    9. Go to - http://localhost:3000/users 


# VALIDATION
    1. User - Email and user name must be unique and not-null. Email should match the matching regex.
    2. Product - Code must be unique and not-null

    3. User Import - While doing data insertion, the invalid will be skipped and all other will be inserted.
    4. Product Import - While doing data insertion, the invalid will be skipped and all other will be inserted.
    5. Order Detail Import - While doing data insertion, once it detects the invalid data - it will raise the exception and the process terminates. Data present prior to current batch will be inserted. Insertion happened for the current batch will be roll-back.





