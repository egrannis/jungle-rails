require 'rails_helper';

RSpec.describe User, type: :model do


  describe 'User Validations' do

    # It must be created with a password and password_confirmation fields
    it 'should create a User if all of the fields are correctly filled in' do
      @user1 = User.new(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password: "abcdefgh", password_confirmation: "abcdefgh")
      expect(@user1).to be_valid
    end

    # It must be created with a password and password_confirmation fields
    it 'should not create a user when a password or a password_confirmation are not present' do
      @user1= User.new(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password:nil, password_confirmation:"abcdefg")
      @user2= User.new(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password:"abcdefg", password_confirmation:nil)
      expect(@user1).to_not be_valid 
      expect(@user2).to_not be_valid 
    end

    # Passwords need to match so you should have an example for where they are not the same
    it 'should validate that a password matches its password_confirmation' do
      @user= User.new(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password:"abcdefgh", password_confirmation:"abcdefg")
      expect(@user).to_not be_valid 
    end

    # Emails must be unique (not case sensitive; for example, TEST@TEST.com should not be allowed if test@test.COM is in the database)
    it 'should validate that an email address is unique' do
      @user1= User.create(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password:"abcdefg", password_confirmation:"abcdefg")
      @user2= User.create(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password:"abcdefg", password_confirmation:"abcdefg")
      expect(@user2).to_not be_valid
    end

    # Email, first name, and last name should also be required
    it 'should validate that user is not created if email, first_name or last_name are not present.' do
      @user1= User.new(first_name: nil, last_name: "Grannis", email: "emma@email.com", password:"abcdefg", password_confirmation:"abcdefg")
      @user2= User.new(first_name: "Emma", last_name:nil, email: "emma@email.com", password:"abcdefg", password_confirmation:"abcdefg")
      @user3= User.new(first_name: "Emma", last_name: "Grannis", email: nil, password:"abcdefg", password_confirmation:"abcdefg")
      expect(@user1).to_not be_valid
      expect(@user2).to_not be_valid
      expect(@user3).to_not be_valid
    end

    # The password must have a minimum length when a user account is being created
    it 'should validate that a password is above a minimum length' do
      @user1 = User.new(first_name: "Emma", last_name: "Grannis", email: "email@test.com", password:"a", password_confirmation:"a")
      expect(@user1).to_not be_valid
    end

    # Email should be able to have spaces bordering and it still pass
    it 'should log the user in even if the email contains spaces' do
      @user1 = User.create(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password: "abcdefgh", password_confirmation: "abcdefgh")
      authenticate = User.authenticate_with_credentials(" emma@email.com  ", "abcdefgh")
      expect(authenticate).to be_valid
    end

    # Email, first name, and last name should also be required
  describe '.authenticate_with_credentials' do
    it 'should validate user authentication with proper name and password' do
      @user1 = User.create(first_name: "Emma", last_name: "Grannis", email: "email@test.com", password:"abcdefgh", password_confirmation:"abcdefgh")
      authenticate = User.authenticate_with_credentials('email@test.com','abcdefgh')
      expect(authenticate).to be_valid
      end
    end
  end
end