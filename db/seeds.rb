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

admin = User.new(name: "Admin", email: "admin@email.com", password: "123456")
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

# Plant buyer

richard = User.new(name: "Richard", email: "richard@email.com", password: "123456")
richard.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605630724/plant-bnb/richard.jpg"), filename: "richard", content_type: "image/jpg")
richard.save!

# Plant owner

martin = User.new(name: "Martin", email: "martin@email.com", password: "123456")
martin.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1603708766/plant-bnb/martin.jpg"), filename: "martin", content_type: "image/jpg")
martin.save!

# First free plant that Richard gets

peace_lily = Plant.new(
  user: stephane,
  price_cents: 0,
  title: "Potted peace lily (free)",
  categories: [house_plants_category, flowers_category],
  description: "I'm moving and I need to get rid of all my plants. This is a beautiful white peace lily I've had for 2 years. Should be kept in low sun light and watered every day.\nPickups only.",
  created_at: DateTime.now - 4.days
)
peace_lily.cover_photo.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605563081/plant-bnb/peace-lily/1515164846613.jpg"), filename: "pl", content_type: "image/jpg")

picture_attriubtes = [
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605563082/plant-bnb/peace-lily/DSCF0200.jpg"), filename: "pl", content_type: "image/jpg" },
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605563081/plant-bnb/peace-lily/peace_plant_georgina198_gettyimages.jpg"), filename: "pl", content_type: "image/jpg" },
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605563081/plant-bnb/peace-lily/96d704dc5b44d784678f358d2a0e6f2c.png"), filename: "pl", content_type: "image/png" },
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605563082/plant-bnb/peace-lily/DSCF0200.jpg"), filename: "pl", content_type: "image/jpg" }
]

picture_attriubtes.each do |picture_attrs|
  peace_lily.pictures.attach(picture_attrs)
end

peace_lily.save!

# The hydrangea that Richard looks at that's too expensive

hydrangea_expensive = Plant.new(
  user: stephane,
  price_cents: 4000,
  title: "Beautiful light blue hydrangea house plant",
  categories: [house_plants_category, flowers_category],
  description: "Keep the soil moist. Dry soil can be the death of this plant. Leaves that turn yellow and fall off are a sign of dry soil. Flowering plants are thirsty, so it's a good idea to check the soil every day while in bloom.\nHydrangea pruning. Mophead hydrangeas don't need to be pruned back unless you want to control their size. Cutting off about 1/3 of the oldest stems will give you a fuller plant. When to prune hydrangeas: After blossoms fade. Hydrangea shrubs are perennials. Woody stems are densely covered with big, oval leaves that are deep green.",
  created_at: DateTime.now - 8.days
)
hydrangea_expensive.cover_photo.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562905/plant-bnb/hydrangea-1/indoor-hydrangea.jpg"), filename: "hydrangea", content_type: "image/jpg")

picture_attriubtes = [
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562905/plant-bnb/hydrangea-1/pl2000034434.jpg"), filename: "hydrangea", content_type: "image/jpg" },
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562905/plant-bnb/hydrangea-1/btgh-hydrangea2.jpg"), filename: "hydrangea", content_type: "image/jpg" },
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562905/plant-bnb/hydrangea-1/c9dd23b2b52c893da8b77cd896f92bb8.jpg"), filename: "hydrangea", content_type: "image/jpg" },
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562905/plant-bnb/hydrangea-1/91f-hlDXWoL._AC_SL1500_.jpg"), filename: "hydrangea", content_type: "image/jpg" }
]

picture_attriubtes.each do |picture_attrs|
  hydrangea_expensive.pictures.attach(picture_attrs)
end

hydrangea_expensive.save!

# The hydrangea that Richard looks at that's just right

hydrangea_cheap = Plant.new(
  user: aline,
  price_cents: 1000,
  title: "White Indoor Hydrangea (Pickups Only)",
  categories: [house_plants_category, flowers_category],
  description: "Care instructions:\n\nHydrangea pruning. Mophead hydrangeas don't need to be pruned back unless you want to control their size. Cutting off about 1/3 of the oldest stems will give you a fuller plant. When to prune hydrangeas: After blossoms fade. Hydrangea shrubs are perennials. Woody stems are densely covered with big, oval leaves that are deep green.\nKeep the soil moist. Dry soil can be the death of this plant. Leaves that turn yellow and fall off are a sign of dry soil. Flowering plants are thirsty, so it's a good idea to check the soil every day while in bloom.",
  created_at: DateTime.now - 12.days
)
hydrangea_cheap.cover_photo.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562947/plant-bnb/hydrangea-2/hydrangea-mophead-white-visi12073-x750.jpg"), filename: "hydrangea", content_type: "image/jpg")

picture_attriubtes = [
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562947/plant-bnb/hydrangea-2/Bengert-Greenhouses-Hydrangeas-2-1024x683.jpg"), filename: "hydrangea", content_type: "image/jpg" },
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562947/plant-bnb/hydrangea-2/pl2000034432_card3_lg.jpg"), filename: "hydrangea", content_type: "image/jpg" },
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562947/plant-bnb/hydrangea-2/c8ec4b6a1fb0b01bade4ca89c9f93e02.jpg"), filename: "hydrangea", content_type: "image/jpg" },
  { io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1605562948/plant-bnb/hydrangea-2/23807.jpg"), filename: "hydrangea", content_type: "image/jpg" }
]

picture_attriubtes.each do |picture_attrs|
  hydrangea_cheap.pictures.attach(picture_attrs)
end

hydrangea_cheap.save

csv_plants = CSV.read(Rails.root.join("db/seed_data.csv"), { headers: true }).map do |row|
  plant = Plant.new({
    user: User.find_by_name(row["user"]),
    price_cents: row["price"].to_i,
    title: row["name"],
    description: "Water slowly and deeply every 2 days and keep in moderate sunlight.",
    categories: [Category.find_by_name(row["primary_category"])],
    created_at: DateTime.now - (0...60).to_a.sample.days
  })

  file_extension = row["cover_photo_url"].match(/\.(\w+)$/)[1]
  plant.cover_photo.attach(io: URI.open(row["cover_photo_url"]), filename: "plant", content_type: "image/#{file_extension}")
  plant.save!
  plant
end

[5, 5, 5, 5, 5, 4, 4, 1].each { |stars| Rating.create(user: admin, plant: stephane.plants.first, stars: stars) }
[5, 4, 4].each { |stars| Rating.create(user: admin, plant: aline.plants.first, stars: stars) }

# Plant position swaps
Plant.all.to_a.shuffle.each(&:touch) # randomly touch all plants
peace_lily.touch # touch peace lily to bring it to the top
csv_plants.shuffle.last(7).each(&:touch) # bring 4 random csv plants to the top