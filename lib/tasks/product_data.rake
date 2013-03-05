namespace :db do
  desc "Fill database with product data"
  task build_catalog: :environment do
    make_products
  end
end

def make_products
	#product = Product.create!(item: "1020RC", description: "Classic Modified 1720 Paring Knife", 
	#													retail: 52.0, cpo: 48, points: 35, category: "Auxilary")
=begin
  admin = User.create!(name: "Rob", email: "rob@cpobaby.com", password: "foobar", password_confirmation: "foobar")
  admin.toggle!(:admin)
  admin.toggle!(:activated)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@cpobaby.com"
    password  = "password"
    user = User.create!(name: name, email: email, password: password, password_confirmation: password)
    user.toggle!(:activated)
  end
=end
end