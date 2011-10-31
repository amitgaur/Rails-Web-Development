# == Schema Information
#
# Table name: products
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  image_url   :string(255)
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
  end

  test "product price must be positive" do
    product = Product.new(:title => "My Book Title",
                          :description => "yyy",
                          :image_url => "zzz.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01",
                 product.errors[:price].join('; ')

  end


  test "product is not valid without a unique title" do
    product = Product.new(:title => products(:ruby).title,
                          :description => "yyy",
                          :price => 1,
                          :image_url => "fred.gif")
    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join('; ')
  end

  def new_product(image_url)

    Product.new(:title => "title", :description => "blah desc", :price =>0.33, :image_url => image_url)

  end


  test "image url" do
    ok = %w{fred.gif fred.jpg fred.png http://blah.com/blah.jpg}

    ok.each { |x| assert new_product(x).valid?, "#{x} should be valid" }
  end

end

