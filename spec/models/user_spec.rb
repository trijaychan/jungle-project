require "rails_helper"

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "initializes with valid fields" do
      @user = User.new(
        first_name: "First",
        last_name: "Last",
        email: "Email",
        password: "password",
        password_confirmation: "password"
      )
      expect(@user).to be_valid
    end

    it "fails when passwords do not match" do
      @user = User.new(
        first_name: "First",
        last_name: "Last",
        email: "Email",
        password: "password",
        password_confirmation: "passwordd"
      )
      expect(@user).to_not be_valid
    end

    it "fails email is not unique" do
      @first = User.first
      @user = User.new(
        first_name: "First",
        last_name: "Last",
        email: @first,
        password: "password",
        password_confirmation: "password"
      )
      expect(@user).to_not be_valid
    end

    it "fails first name is nil" do
      @user = User.new(
        first_name: nil,
        last_name: "Last",
        email: "Email",
        password: "password",
        password_confirmation: "password"
      )
      expect(@user).to_not be_valid
    end

    it "fails last name is nil" do
      @user = User.new(
        first_name: "First",
        last_name: nil,
        email: "Email",
        password: "password",
        password_confirmation: "password"
      )
      expect(@user).to_not be_valid
    end

    it "fails email is nil" do
      @user = User.new(
        first_name: "First",
        last_name: "Last",
        email: nil,
        password: "password",
        password_confirmation: "password"
      )
      expect(@user).to_not be_valid
    end

    it "fails when password is too short" do
      @user = User.new(
        first_name: "First",
        last_name: "Last",
        email: nil,
        password: "pass",
        password_confirmation: "pass"
      )
      expect(@user).to_not be_valid
    end
  end

  describe ".authenticate_with_credentials" do
    before do
      @sample = User.create(
        first_name: "First",
        last_name: "Last",
        email: "Email",
        password: "password",
        password_confirmation: "password"
      )
    end

    it "returns nil with invalid password" do 
      @user = User.authenticate_with_credentials("Email", "wrong_pass")
      expect(@user).to be_nil
    end

    it "returns user instance with valid fields" do
      @user = User.authenticate_with_credentials("Email", "password")
      expect(@user).to be_truthy
    end

    it "authenticates email with trailing spaces" do
      @user = User.authenticate_with_credentials(" Email ", "password")
      expect(@user).to be_truthy
    end

    it "authenticates case-insensitive email" do
      @user = User.authenticate_with_credentials("eMaiL", "password")
      expect(@user).to be_truthy
    end
  end

end