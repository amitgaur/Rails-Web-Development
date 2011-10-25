require 'test_helper'

class ProductTest < ActiveSupport::TestCase
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

  def new_product(image_url)

    Product.new(:title => "title", :description => "blah desc", :price =>0.33, :image_url => image_url)

  end


  test "image url" do
    ok = %w{fred.gif fred.jpg. fred.png, http://blah.com/blah.jpg}
    bad = %w{fred.doc blah.img}

    ok.each { |x| assert new_product(x).valid?, "#{x} should be valid" }

  end

end

