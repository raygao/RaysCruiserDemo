require 'spec_helper'


describe URole, :core => true do

  before(:all) do
    puts "Creating User Roles: 'admin' or 'regular' users"
    @admin_role = UserRole.create! name: 'admin', description: "Application Administrator"
    @regular_role = URole.create! name: 'regular', description: "Regular application user"
    URole.count == 2
  end

   describe "seed user role" do
     it "creates user with 'admin' role" do
       @admin_role != nil
       puts 'admin id is ' + @admin_role.id.to_s
       puts 'admin role is ' + @admin_role.name
       @user = User.create! first_name: "Administrator", last_name: "RBS", email: "admin@rays-cruiser.com", password:"123456",
                           password_confirmation: "123456", user_role: @admin_role, business_name: "Rays cruiser Shop",
                           zip: "75231"
       puts "-- New user created: #{@user.email}, role '#{@user.user_role.name}'  @ #{Time.now}."
       User.count == 1
     end
   end

  after(:all) do
    @user.delete
    @admin_role.delete
    @regular_role.delete
  end


end
