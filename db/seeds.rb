srand(1)

require "open-uri"
require "csv"

class ApplicationRecord
  after_save :log_create_for_seed
  after_destroy :log_destroy_for_seed

  def log_create_for_seed
    puts JSON.pretty_generate name: self.class, attributes: self.attributes
  end

  def log_destroy_for_seed
    puts "destroying #{self.class}"
  end
end

User.destroy_all
Category.destroy_all

house_plants_category    = Category.create!(name: "house plants")
for_your_garden_category = Category.create!(name: "for your garden")
flowers_category         = Category.create!(name: "flowers")
office_plants_category   = Category.create!(name: "office plants")
shrubs_category          = Category.create!(name: "shrubs")
trees_category           = Category.create!(name: "trees")
artificial_category      = Category.create!(name: "artificial")

admin = User.new(name: "Martin", email: "admin@email.com", password: "123456")
admin.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1603708766/plant-bnb/martin.jpg"), filename: "admin", content_type: "image/jpg")
admin.save!

sangwoo = User.new(name: "Sangwoo", email: "sangwoo@email.com", password: "123456")
sangwoo.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1603708766/plant-bnb/sangwoo.jpg"), filename: "sangwoo", content_type: "image/jpg")
sangwoo.save!

aline = User.new(name: "Aline", email: "aline@email.com", password: "123456")
aline.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1604297653/plant-bnb/aline.jpg"), filename: "aline", content_type: "image/jpg")
aline.save!

lea = User.new(name: "Lea", email: "lea@email.com", password: "123456")
lea.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1604297653/plant-bnb/lea.png"), filename: "lea", content_type: "image/png")
lea.save!

camille = User.new(name: "Camille", email: "camille@email.com", password: "123456")
camille.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1604297653/plant-bnb/camille.jpg"), filename: "camille", content_type: "image/jpg")
camille.save!

stephane = User.new(name: "Stephane", email: "stephane@email.com", password: "123456")
stephane.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1604297653/plant-bnb/stephane.jpg"), filename: "stephane", content_type: "image/jpg")
stephane.save!

mg = User.new(name: "MG", email: "mg@email.com", password: "123456")
mg.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1604297653/plant-bnb/mg.jpg"), filename: "mg", content_type: "image/jpg")
mg.save!

antoine = User.new(name: "Antoine", email: "antoine@email.com", password: "123456")
antoine.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1604297653/plant-bnb/antoine.jpg"), filename: "antoine", content_type: "image/jpg")
antoine.save!

alina = User.new(name: "Alina", email: "alina@email.com", password: "123456")
alina.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1604297653/plant-bnb/alina.jpg"), filename: "alina", content_type: "image/jpg")
alina.save!

alex = User.new(name: "Alex", email: "alex@email.com", password: "123456")
alex.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1604297653/plant-bnb/alex.jpg"), filename: "alex", content_type: "image/jpg")
alex.save!

CSV.read(Rails.root.join("db/seed_data.csv"), { headers: true }).each do |row|
  plant = Plant.new({
    user: User.find_by_name(row["user"]),
    price_cents: row["price"].to_i,
    title: row["name"].send(["capitalize", "titleize", "upcase", "downcase"].sample),
    description: "Water slowly and deeply every 2 days and keep in moderate sunlight.",
    categories: [Category.find_by_name(row["primary_category"])]
  })

  file_extension = row["cover_photo_url"].match(/\.(\w+)$/)[1]
  plant.cover_photo.attach(io: URI.open(row["cover_photo_url"]), filename: row["name"], content_type: "image/#{file_extension}")
  plant.save!
end

# sangwoos_plant_1 = create_plant_from_existing_cl_file(
#   "v1603708107/plant-bnb/plant-1",
#   user: sangwoo,
#   price_cents: 900,
#   title: "Plante hypoeste rose/pink polka dots plant",
#   description: "Indoor evergreen plant, in different sizes. Easy to care.",
#   categories: [trees_category, for_your_garden_category]
# )

# sangwoos_plant_2 = create_plant_from_existing_cl_file(
#   "v1603708107/plant-bnb/plant-2",
#   user: sangwoo,
#   price_cents: 800,
#   title: "Plante mauve oxalis",
#   description: "Indoor evergreen plant, in different sizes. Easy to care.",
#   categories: [house_plants_category, artificial_category]
# )

# sangwoos_plant_3 = create_plant_from_existing_cl_file(
#   "v1603708107/plant-bnb/plant-3",
#   user: sangwoo,
#   price_cents: 0,
#   title: "Trinidad Moruga Scorpion bio/ Organic trinidad Moruga ",
#   description: "Indoor evergreen plant, in different sizes. Easy to care.",
#   categories: [trees_category, shrubs_category]
# )

# sangwoos_plant_4 = create_plant_from_existing_cl_file(
#   "v1603708107/plant-bnb/plant-4",
#   user: sangwoo,
#   price_cents: 900,
#   title: "28'' Artificial Foliage Plant",
#   description: "Indoor evergreen plant, in different sizes. Easy to care.",
#   private: true,
#   categories: [trees_category, shrubs_category, office_plants_category]
# )

# alines_plant_1 = create_plant_from_existing_cl_file(
#   "v1603708107/plant-bnb/plant-5",
#   user: aline,
#   price_cents: 900,
#   title: "Artificial Fiddle Leaf Fig Plant",
#   description: "Indoor evergreen plant, in different sizes. Easy to care.",
#   categories: [trees_category, office_plants_category]
# )

# alines_plant_2 = create_plant_from_existing_cl_file(
#   "v1603708107/plant-bnb/plant-6",
#   user: aline,
#   price_cents: 900,
#   title: "Plante araignée frisée/ curly spider plant",
#   description: "Indoor evergreen plant, in different sizes. Easy to care.",
#   categories: [trees_category, artificial_category]
# )

# alines_plant_3 = create_plant_from_existing_cl_file(
#   "v1603708107/plant-bnb/plant-7",
#   user: aline,
#   price_cents: 900,
#   title: "Bulbes de Canna feuilles rouge",
#   description: "Indoor evergreen plant, in different sizes. Easy to care.",
#   categories: [artificial_category, office_plants_category]
# )

# alines_plant_4 = create_plant_from_existing_cl_file(
#   "v1603708107/plant-bnb/plant-8",
#   user: aline,
#   price_cents: 0,
#   title: "Mother-in-law-tongue/Snake Plant/Sansevieria t",
#   description: "Indoor evergreen plant, in different sizes. Easy to care.",
#   categories: [trees_category]
# )

# alines_plant_5 = create_plant_from_existing_cl_file(
#   "v1603708108/plant-bnb/plant-9",
#   user: aline,
#   price_cents: 1100,
#   title: "PLANTES DE FIGUES EN POT",
#   description: "Indoor evergreen plant, in different sizes. Easy to care.",
#   private: true,
#   categories: [trees_category, trees_category]
# )

# Favourite.create!(user: sangwoo, plant: alines_plant_1)
# Favourite.create!(user: aline, plant: sangwoos_plant_1)

# Rating.create!(user: sangwoo, plant: alines_plant_2, stars: 5)

# Rating.create!(user: aline, plant: sangwoos_plant_2, stars: 5)

# PlantInterest.create!(user: aline, plant: sangwoos_plant_2)
# message = Message.create!(sender: aline, receiver: sangwoo, content: "Hey Martin! Can I come pick up this plant tomorrow morning?")
# alines_chat_with_sangwoo = Chat.create!(user: aline, other_user: sangwoo, number_of_unread_messages: 0)
# sangwoos_chat_with_aline = Chat.create!(user: sangwoo, other_user: aline, number_of_unread_messages: 1)
# Notification.create!(
#   chat: sangwoos_chat_with_aline,
#   title: "<strong>#{aline.name}</strong> is interested in your plant \"<strong>#{sangwoos_plant_2.title}</strong>\"",
#   message_preview: message.content
# )
