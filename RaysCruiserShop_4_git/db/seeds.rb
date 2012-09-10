# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



logger = Rails.logger
puts "==Emptying MONGODB DB=="

#Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
Mongoid.default_session.collections.each do |collection|
  unless collection.name =~ /^system\./
    collection.drop
  end
end

puts '==Now creating UserRoles & Users=='
puts "Creating Urole: 'admin' or 'regular' users"
admin = Urole.create! name: 'admin', description: "Application Administrator"
regular = Urole.create! name: 'regular', description: "Regular application user"
puts "#{Urole.count} roles have bee created."

puts "Creating Admin User."
user = User.create! first_name: "Chris", last_name: "Hoy", email: "admin@rays-cruiser.com", password:"123456",
                    password_confirmation: "123456", user_role: admin, business_name: "Rays Cruiser FrontOffice",
                    zip: "75231"
puts "-- New user created: #{user.email}, role '#{user.user_role.name}'  @ #{Time.now}."

puts "==Creating ItemTypes=="
puts "Creating ItemType, 'Steering', 'Tire', 'Frame', 'Brake', 'Pedal', 'Light', 'Seat'"
steering = ItemType.create! name: "Steering", description: "Steering bar"
tire = ItemType.create! name: "Tire", description: "Tire"
frame = ItemType.create! name: "Frame", description: "Frame"
brake = ItemType.create! name: "Brake", description: "Brake"
pedal = ItemType.create! name: "Pedal", description: "Pedal"
light = ItemType.create! name: "Light", description: "Light"
seat = ItemType.create! name: "Seat", description: "Seat"
puts "#{ItemType.count} item types have bee created."

puts '==Adding Items=='
# read http://stackoverflow.com/questions/3910162/seeding-file-uploads-with-carrierwave-rails-3
# regarding how to seed the Item with Image files
# examples
# street_grip = Rails.root.join('item_images', 'street_grip_tire.jpg')
# uploader  = ImageUploader.create!(:item => Item)
# it = Item.create!()
# it.image.store!(File.open(street_grip))
# it.update_attributes(name:'junk')
# ity = ItemType.last
# it.update_attributes(item_type: ity)

# TODO image_filename is not correct, it's using UID and does not match AWS, need to reread Carrierwave
require Rails.root.join('app', 'uploaders', 'image_uploader.rb')
require 'rails'
require 'carrierwave/mongoid'

# Apparently the statement below is not needed.
#uploader  = ImageUploader.create!(:item => Item) #Not sure why it is erroring out here, create! method undefined?.

it = Item.create!(description: "Bike Parts - 9\" high x 28\" wide, chrome gullwing-bar handlebars, 7/8\" tube diameter to stem, 7/8\" tube diameter to grips. 2.5\" space across to place stem",
  item_type_id: ItemType.where(:name => 'Steering').first.id,
  name: "Gulf Swing Handle Bar",
  price: 22,
  quantity: 4,
  remaining_quantity: 7
)
item_image= Rails.root.join('item_images', 'gulf_swing_handle_bar.jpg')
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: '20\"x 1.75\" black wall street grip tire  Note: this tire works well on a 20\"x1.75\" up to a 20\"x2.125 wheel rim',
  item_type_id: ItemType.where(:name => 'Tire').first.id,
  name: "Street Grip Tire",
  price: '12.99',
  quantity: 7,
  remaining_quantity: 20
)
item_image= Rails.root.join('item_images', "street_grip_tire.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: '20\" x 3\" black wall tire. Use with a 20\"x2.125\" tube. Note: this tire works well on a 20\"x1.75\" up to a 20\"x3.0\" wheel rim.',
  item_type_id: ItemType.where(:name => 'Tire').first.id,
  name: "Chopper Tire",
  price: 34,
  quantity: 8,
  remaining_quantity: 15
)
item_image= Rails.root.join('item_images', "chopper_tire.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Bike Parts - 20\" GREEN lowrider frame will accept 20\" rear wheel. Use with 20\" bent or straight springer fork and a 22.2mm or 21.1mm headset and 22.2mm or 21.1mm stem.Includes: lowrider seat post clamp, headset cups, and crank bearing cups.50',
  item_type_id: ItemType.where(:name => 'Frame').first.id,
  name: "Lower Rider Green Frame",
  price: 50,
  quantity: 11,
  remaining_quantity: 6
)
item_image= Rails.root.join('item_images', "low_rider_green_frame.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'One of a Kind lowrider show bicycle tank frame.  With this frame your chances of building a winning show bicycle are increased !  Professionally shaped and painted by automotive paint specialist, this yellow sparkle paint screams in the direct sunlight.   This frame is made for display purpose only, it is not for building a bicycle to ride.\r\n\r\nFrame size is standard lowrider 20\"\r\n \r\nVIDEO - take a quick tour around the frame.\r\n \r\nView example display bike using this frame.  The frame is sold alone, other parts shown in the example photo are sold seperately.\r\nPart #: 514900',
  item_type_id: ItemType.where(:name => 'Frame').first.id,
  name: "Low Rider Special Yellow Frame",
  price: 499,
  quantity: 1,
  remaining_quantity: 1
)
item_image= Rails.root.join('item_images', "lower_rider_special_yellow_frame.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: '20\" chrome standard BMX frame, will accept a 20\" rear wheel with 20\"x3\" tire\r\nPart #: 514005',
  item_type_id: ItemType.where(:name => 'Frame').first.id,
  name: "BMX frame",
  price: 40,
  quantity:4,
  remaining_quantity: 5
)
item_image= Rails.root.join('item_images', "bmx_frame.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Bike Parts - Z2 STRETCH Cruiser frame with tank BLUE - will accept 24\" or 26\" rear wheel. Use a straight springer fork and a 22.2mm headset, or a 1\" steering tube chopper fork with a 1\" chopper headset.\r\nPart #: 514831',
  item_type_id: ItemType.where(:name => 'Frame').first.id,
  name: "Stretched Cruiser Frame",
  price: 179,
  quantity: 5,
  remaining_quantity: 8
)
item_image= Rails.root.join('item_images', "stretched_cruiser_frame.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Lowrider bike parts - front handbrake designed to go over a 20\" classic front fender, kit includes the front lowrider handbrake, front hand lever, and 60\" cable. \r\nPart #: 840204',
  item_type_id: ItemType.where(:name => 'Brake').first.id,
  name: "Low Rider Brake",
  price: 29,
  quantity: 5,
  remaining_quantity: 25
)
item_image= Rails.root.join('item_images', "lower_rider_brake.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Double coaster sprocketnote: this is used on trike kit 870000\r\nPart #: 860009',
  item_type_id: ItemType.where(:name => 'Brake').first.id,
  name: "Double Coaster Brake",
  price: 49,
  quantity: 9,
  remaining_quantity: 5
)
item_image= Rails.root.join('item_images', "double_coaster_brake.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Bike Parts - guitar pedal 9/16\" screw Use with 3 piece crank set #510100 see cranks\r\nPart #: 524120',
  item_type_id: ItemType.where(:name => 'Pedal').first.id,
  name: "Guitar Pedal",
  price: 49,
  quantity: 3,
  remaining_quantity: 12
)
item_image= Rails.root.join('item_images', "guitar_pedal.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: '9/16\" screw black rubber cruiser pedals,  built in amber reflector, great for beach cruisers.\r\nPart #: 524008',
  item_type_id: ItemType.where(:name => 'Pedal').first.id,
  name: "Beach Cruiser Pedal",
  price: 12.99,
  quantity:5,
  remaining_quantity: 8
)
item_image= Rails.root.join('item_images', "beach_cruiser_pedal.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: "flame cruiser seat",
  item_type_id: ItemType.where(:name => 'Seat').first.id,
  name: "Flame Cruiser Seat",
  price: 40,
  quantity: 9,
  remaining_quantity: 12
)
item_image= Rails.root.join('item_images', "cruiser_seat.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Lowrider chrome flat twist pedals 1/2\" screw (pair)\r\nPart #: 524101',
  item_type_id: ItemType.where(:name => 'Pedal').first.id,
  name: "Low Rider Pedal",
  price: 25,
  quantity: 6,
  remaining_quantity: 4
)
item_image= Rails.root.join('item_images', "low_rider_pedal.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Bike Parts - chrome BirdCage pedals 1/2\" screw\r\nPart #: 524117',
  item_type_id: ItemType.where(:name => 'Pedal').first.id,
  name: "BirdCage Pedal",
  price: 49.99,
  quantity:33,
  remaining_quantity: 7
)
item_image= Rails.root.join('item_images', "birdcage_pedal.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Bike Parts - gold round double square twist pedals 1/2\" screw\r\nPart #: 524114',
  item_type_id: ItemType.where(:name => 'Pedal').first.id,
  name: "Gold Butterfly Pedal",
  price: 54.99,
  quantity:3,
  remaining_quantity: 8
)
item_image= Rails.root.join('item_images', "gold_butterfly_pedal.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'cruiser 4 button seat (generic)\r\nPart #: 530405',
  item_type_id: ItemType.where(:name => 'Seat').first.id,
  name: "Black Seat",
  price: 27,
  quantity:14,
  remaining_quantity: 4
)
item_image= Rails.root.join('item_images', "black_seat.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: '20\" Bicycle Banana Seat -2-tone red/white swirl veloure banana seat with extra cushion\r\nActual length 18\" from end to end, width at sissybar screws is about 5\" wide\r\nPart #: 529709\r\n',
  item_type_id: ItemType.where(:name => 'Seat').first.id,
  name: "Red White Banana Seat",
  price: 35,
  quantity:10,
  remaining_quantity: 7
)
item_image= Rails.root.join('item_images', "red_white_banana_seat.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: '20\" chrome flat twist banana seat\r\nPart #: 529500',
  item_type_id: ItemType.where(:name => 'Seat').first.id,
  name: "Twisted Chrome Seat",
  price: 50,
  quantity:8,
  remaining_quantity: 5
)
item_image= Rails.root.join('item_images', "twisted_chrome_seat.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Bike Parts - Bullet Light Chrome with gold visor - uses 2 AA batteries, mounts to stem, uses two standard incandecent mini light bulbs Part #: 520004',
  item_type_id: ItemType.where(:name => 'Light').first.id,
  name: "Bullet Light Chrome",
  price: 25.99,
  quantity:4,
  remaining_quantity: 5
)
item_image= Rails.root.join('item_images', "bullet_light_chrome.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Bike Parts - LED Bullet Light Black with visor - uses 9 volt battery, mounts to stem, uses one LED light bulb.',
  item_type_id: ItemType.where(:name => 'Light').first.id,
  name: "LED Black Light",
  price: 27,
  quantity:21,
  remaining_quantity: 4
)
item_image= Rails.root.join('item_images', "led_black_light.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: 'Bike Parts - 19\" high x 36\" wide chrome apehanger handlebars, 7/8\" tube diameter to stem, 7/8\" tube diameter to grips',
  item_type_id: ItemType.where(:name => 'Steering').first.id,
  name: "Apehanger Handlebar",
  price: 29.99,
  quantity:8,
  remaining_quantity: 4
)
item_image= Rails.root.join('item_images', "apehanger_handle_bar.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record

it = Item.create!(description: '7\" high x 27\" wide chrome moon cruiser handlebars #516006 + black foam grips 515105, 1\" tube diameter to stem, 7/8\" diameter to grips',
  item_type_id: ItemType.where(:name => 'Steering').first.id,
  name: "Moon Cruiser Handle Bar",
  price: 24.99,
  quantity:4,
  remaining_quantity: 7
)
item_image= Rails.root.join('item_images',  "moon_cruiser_handle_bar.jpg")
it.image.store!(File.open(item_image))
it.update_attributes() # must call update_attributes() again, otherwise the itemimage is not written to the record