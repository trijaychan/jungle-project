require "rails_helper"

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.new(id: 1, name: "Category")
    end

    it "fails to initialize" do
      expect(Product.new).to_not be_valid
    end

    it "successfully initializes" do@product = Product.new(
      name: "Product",
      price: 10,
      quantity: 2,
      category: @category
    )
      expect(@product).to be_valid
    end

    it "fails when name is nil" do
      @product = Product.new(
        name: nil,
        price: 10,
        quantity: 2,
        category: @category
      )
      expect(@product).to_not be_valid
    end

    it "fails when price is nil" do
      @product = Product.new(
        name: "Product",
        price: nil,
        quantity: 2,
        category: @category
      )
      expect(@product).to_not be_valid
    end

    it "fails when quantity is nil" do
      @product = Product.new(
        name: "Product",
        price: 10,
        quantity: nil,
        category: @category
      )
      expect(@product).to_not be_valid
    end

    it "fails when cateogry is nil" do
      @product = Product.new(
        name: "Product",
        price: 10,
        quantity: 2,
        category: nil,
      )
      expect(@product).to_not be_valid
    end

  end

end