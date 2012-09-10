require 'spec_helper'

describe UserRole, :core => true do
#  pending "add some examples to (or delete) #{__FILE__}"
   describe "seed user role" do

     it "has a clean db" do
       URole.count == 0
     end

     it "creates user roles" do
       puts "Creating User Roles: 'admin' or 'regular' users"
       @admin_role = UserRole.create! name: 'admin', description: "Application Administrator"
       @regular_role = UserRole.create! name: 'regular', description: "Regular application user"
       URole.count == 2
       @admin_role.delete
       @regular_role.delete
     end

   end

end
