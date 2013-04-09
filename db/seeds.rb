# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:firstname => 'Admin', :lastname => 'Tester', :username => 'admin', :email => 'admin@foodwebbuilder.com', :password => '12345678', :role => 'admin', :approved => 1, :project_id =>1)

User.create(:firstname => 'Moderator', :lastname => 'Tester', :username => 'mod', :email => 'mod@foodwebbuilder.com', :password => '12345678', :role => 'moderator', :approved => 1, :project_id =>1)

User.create(:firstname => 'User', :lastname => 'Tester', :username => 'user', :email => 'user@foodwebbuilder.com', :password => '12345678', :role => 'user', :approved => 1, :project_id =>1)

User.create(:firstname => 'Project', :lastname => 'Lead', :username => 'lead', :email => 'lead@foodwebbuilder.com', :password => '12345678', :role => 'lead', :approved => 1, :project_id =>1)


LocationData.create(latitude: 42.31276,longitude: -71.03645,location_id: 1,name: "UMASS BOSTON", :user_id =>1, :project_id => 1)
