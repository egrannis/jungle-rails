require 'rails_helper';

RSpec.describe User, type: :model do


  describe 'User Validations' do

    # It must be created with a password and password_confirmation fields
    it 'should create a User if all of the fields are correctly filled in' do
      @user1 = User.create!(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password: "abcdefgh", password_confirmation: "abcdefgh")
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


  describe '.authenticate_with_credentials' do
    # Email should be able to have spaces bordering and it still pass
    it 'should return the user if it exists in the database and PW is correct' do
      @user1 = User.create!(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password: "abcdefgh", password_confirmation: "abcdefgh")
      authenticatedUser = User.authenticate_with_credentials("emma@email.com", "abcdefgh")
      expect(@user1).to eq(authenticatedUser) 
    end

    # Email, first name, and last name should also be required
    it 'should return the user even if trailing and preceding whitespace in email' do
      @user1 = User.create!(first_name: "Emma", last_name: "Grannis", email: "email@test.com", password:"abcdefgh", password_confirmation:"abcdefgh")
      authenticatedUser = User.authenticate_with_credentials('  email@test.com  ','abcdefgh')
      expect(@user1).to eq(authenticatedUser) 
      end
    
    # test for case sensitivity of email
    it 'should return the user even if email has capitalizations in it differing from DB' do
      @user1 = User.create!(first_name: "Emma", last_name: "Grannis", email: "email@test.com", password:"abcdefgh", password_confirmation:"abcdefgh")
      authenticatedUser = User.authenticate_with_credentials('eMAil@test.com','abcdefgh')
      expect(@user1).to eq(authenticatedUser) 
      end 
    # test if user does not EXIST - search user database with an email not present, make sure returns nil
    it 'should return nil if the user does not exist in the DB' do
      authenticatedUser = User.authenticate_with_credentials('nouser@email.com','abcdefgh')
      expect(authenticatedUser).to eq(nil)
      end 

    # test if email is in DB, but PW is wrong - should return nil
    it 'should return nil if the user does not exist in the DB' do
      @user1 = User.create!(first_name: "Emma", last_name: "Grannis", email: "email@test.com", password:"abcdefgh", password_confirmation:"abcdefgh")
      authenticatedUser = User.authenticate_with_credentials('email@test.com','abcdefghijklmnop')
      expect(authenticatedUser).to eq(nil)
      end 

    end
  end
end
