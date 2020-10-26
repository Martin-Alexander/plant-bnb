require "open-uri"

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

def create_plant_from_existing_cl_file(cl_image_id, plant_attriubutes)
  url = "https://res.cloudinary.com/dr6nzroni/image/upload/#{cl_image_id}.png"

  plant = Plant.new(plant_attriubutes)

  plant.cover_photo.attach(io: URI.open(url), filename: cl_image_id, content_type: "image/png")
  plant.save!

  plant
end

User.destroy_all
Category.destroy_all

martin = User.new( name: "Martin", email: "martin@email.com", password: "123456")
martin.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1603708766/plant-bnb/martin.jpg"), filename: "martin", content_type: "image/jpg")
martin.save!

sangwoo = User.new( name: "Sangwoo", email: "sangwoo@email.com", password: "123456")
sangwoo.profile_picture.attach(io: URI.open("https://res.cloudinary.com/dr6nzroni/image/upload/v1603708766/plant-bnb/sangwoo.jpg"), filename: "sangwoo", content_type: "image/jpg")
sangwoo.save!

martins_plant_1 = create_plant_from_existing_cl_file(
  "v1603708107/plant-bnb/plant-1",
  user: martin,
  price_cents: 900,
  title: "Plante hypoeste rose/pink polka dots plant",
  description: "Indoor evergreen plant, in different sizes. Easy to care."
)

martins_plant_2 = create_plant_from_existing_cl_file(
  "v1603708107/plant-bnb/plant-2",
  user: martin,
  price_cents: 800,
  title: "Plante mauve oxalis",
  description: "Indoor evergreen plant, in different sizes. Easy to care."
)

martins_plant_3 = create_plant_from_existing_cl_file(
  "v1603708107/plant-bnb/plant-3",
  user: martin,
  price_cents: 0,
  title: "Trinidad Moruga Scorpion bio/ Organic trinidad Moruga ",
  description: "Indoor evergreen plant, in different sizes. Easy to care."
)

martins_plant_4 = create_plant_from_existing_cl_file(
  "v1603708107/plant-bnb/plant-4",
  user: martin,
  price_cents: 900,
  title: "28'' Artificial Foliage Plant",
  description: "Indoor evergreen plant, in different sizes. Easy to care."
)

sangwoos_plant_1 = create_plant_from_existing_cl_file(
  "v1603708107/plant-bnb/plant-5",
  user: sangwoo,
  price_cents: 900,
  title: "Artificial Fiddle Leaf Fig Plant",
  description: "Indoor evergreen plant, in different sizes. Easy to care."
)

sangwoos_plant_2 = create_plant_from_existing_cl_file(
  "v1603708107/plant-bnb/plant-6",
  user: sangwoo,
  price_cents: 900,
  title: "Plante araignée frisée/ curly spider plant",
  description: "Indoor evergreen plant, in different sizes. Easy to care."
)

sangwoos_plant_3 = create_plant_from_existing_cl_file(
  "v1603708107/plant-bnb/plant-7",
  user: sangwoo,
  price_cents: 900,
  title: "Bulbes de Canna feuilles rouge",
  description: "Indoor evergreen plant, in different sizes. Easy to care."
)

sangwoos_plant_4 = create_plant_from_existing_cl_file(
  "v1603708107/plant-bnb/plant-8",
  user: sangwoo,
  price_cents: 0,
  title: "Mother-in-law-tongue/Snake Plant/Sansevieria t",
  description: "Indoor evergreen plant, in different sizes. Easy to care."
)

sangwoos_plant_5 = create_plant_from_existing_cl_file(
  "v1603708108/plant-bnb/plant-9",
  user: sangwoo,
  price_cents: 1100,
  title: "PLANTES DE FIGUES EN POT",
  description: "Indoor evergreen plant, in different sizes. Easy to care."
)

Favourite.create!(user: martin, plant: sangwoos_plant_1)
Favourite.create!(user: sangwoo, plant: martins_plant_1)

Rating.create!(user: martin, plant: sangwoos_plant_2, stars: 5)

Rating.create!(user: sangwoo, plant: martins_plant_2, stars: 5)

PlantInterest.create!(user: martin, plant: sangwoos_plant_2)
Message.create(sender: martin, receiver: sangwoo, content: "Hey Sangwoo! I can come pick it up tomorrow morning. Does 10 work?")

PlantInterest.create!(user: sangwoo, plant: martins_plant_2)
Message.create(sender: sangwoo, receiver: martin, content: "Hey Martin! Can I come pick up this plant tomorrow morning?")