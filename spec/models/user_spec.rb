require 'rails_helper'

RSpec.describe User, type: :model do

  it "email不能重複" do
    user = User.create(
    email: "admin@flycat.works",
    password: "123456",
    password_confirmation: "123456"
    )

    u = User.create(
      email: "admin@flycat.works",
      password: "12345678",
      password_confirmation: "12345678"
      )

    expect(u.errors.any?).to be true
  end
  
  it "email必填" do
    user = User.new(
      email:"",
      password:"123456",
      password_confirmation: "123456"
    )
    expect(user).to_not be_valid
  end

  it "password必填" do
    user = User.new(
      email:"kk@gmail.com",
      password:"",
      password_confirmation: "123456"
    )
    expect(user).to_not be_valid
  end

  it "password_confirmation須與password相同" do
    user = User.new(
      email:"kk@gmail.com",
      password:"1234567",
      password_confirmation: "123456"
    )
    expect(user).to_not be_valid
  end

  it "belongs to company" do
    company = Company.create(title:"cat", ubn:24496001)
    user = User.create(email: "admin@flycat.works",
    password: "12345678",
    password_confirmation: "12345678")
    company.users << user
    expect(company.users).to include(user) 
  end

end
