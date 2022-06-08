require rails_helper;

RSpec.describe User, type: :model do


  describe 'User Validations' do

    # It must be created with a password and password_confirmation fields
    it 'should create a User if all of the fields are correctly filled in' do
      @user1 = User.new(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password: "abc", password_confirmation: "abc")
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
      @user= User.new(first_name: "Emma", last_name: "Grannis", email: "emma@email.com", password:"abcd", password_confirmation:"abcdefg")
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
      @user= User.new(first_name: "Emma", last_name: "Grannis", email: "email@test.com", password:"1", password_confirmation:"1")
      expect(@user).to_not be_valid
    end

    # Email, first name, and last name should also be required
  describe '.authenticate_with_credentials' do
    it 'should validate user authentication with name and password' do
      @user = User.create(first_name: "Emma", last_name: "Grannis", email: "email@test.com", password:"123456", password_confirmation:"123456")
      authenticate = User.authenticate_with_credentials(@user.email, @user.password)
      expect(authenticate).to_not be_valid
      end
    end
  end
end




RSpec.describe User, type: :model do
  describe 'Validations' do
    
   
  describe '.authenticate_with_credentials' do
    it 'should log the user in if the credentials are correct' do
      @user = User.new(first_name: "John", last_name: "Smith", email: "johnny123@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("johnny123@gmail.com", "ABCDEF")).to be_present
    end
    it 'should not log the user in if the email is wrong' do
      @user = User.new(first_name: "John", last_name: "Smith", email: "johnny123@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("johnny1234@gmail.com", "ABCDEF")).not_to be_present
    end
    it 'should not log the user in if the password is wrong' do
      @user = User.new(first_name: "John", last_name: "Smith", email: "johnny123@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("johnny123@gmail.com", "ABCDEFG")).not_to be_present
    end
    it 'should log the user in even if the email contains spaces' do
      @user = User.new(first_name: "John", last_name: "Smith", email: "johnny1234@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("  johnny1234@gmail.com   ", "ABCDEF")).to be_present
    end
    it 'should log the user in even if the email is typed with a different case' do
      @user = User.new(first_name: "John", last_name: "Smith", email: "johnny1234@gmail.com", password: "ABCDEF", password_confirmation: "ABCDEF")
      @user.save!
      expect(User.authenticate_with_credentials("  JOHNNY1234@gmail.com   ", "ABCDEF")).to be_present
    end
  end
end