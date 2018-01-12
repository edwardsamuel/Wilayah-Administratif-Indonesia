# MySQL to MongoDB conversion
Using Mongify, a ruby based application to convert and translate mysql database to mongodb.
Please check http://mongify.com/getting_started.html

# Getting started
- Install mongify `gem install mongify`
- Make sure you have import the wilayah-administratif-indonesia dump file (indonesia.mysql) on your running MySQL database
- Make sure you have a running MongoDB
- Check `database.config` and adjust the connection crendentials for both MySQL and MongoDB
- Run `mongify check database.config` to verify the connection
- Run the conversion process `mongify process database.config translation.rb`
