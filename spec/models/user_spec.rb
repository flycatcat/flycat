require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { build(:user) }

  it "email 不能重複" do
   user.email = "flycat@gmail.com"
   expect(user).to_not be_valid
  end
  
  it "email 必填" do
    user.email = ''
    expect(user).to_not be_valid
  end

  it "password 必填" do
    user.password = ''
    expect(user).to_not be_valid
  end

  it "password_confirmation 須與 password 相同" do
    user = build(:user,password_confirmation: 222222)
    expect(user).to_not be_valid
  end

end
