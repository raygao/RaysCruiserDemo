Feature: Setup application
  1st, seed the application with user roles. This should be done only once after application is first deployed, because
  it will wiped the data store clean and insert 1 user with admin role. (ray) see "db/seeds.rb" file.

Scenario: Seeding the application
  Given MongoDB server has been started.
  When Seeding the DB
  Then DB is seeded with 'admin' & 'user' roles; and, 'ray' as the admin.

