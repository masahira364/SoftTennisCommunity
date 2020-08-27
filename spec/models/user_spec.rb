require 'rails_helper'

RSpec.describe User, type: :model do

	describe "ユーザーの登録" do

		context "登録の成功" do
			before do
				@user = User.create(nickname: "tes", email: "tes@mail", password: "aaaaaa")
				@user.save
			end
		  	it "ニックネームとメールアドレスとパスワードがあれば登録できる" do
		  		expect(@user).to be_valid
		  	end
		end

		context "登録の失敗" do
		  	it "名前がなければ登録できない" do
		  		@user = User.new(nickname: "", email: "tes@mail", password: "aaaaaa")
		  		@user.save
		  		expect(@user).to be_invalid
		  	end
		  	it "メールアドレスがなければ登録できない" do
		  		@user = User.new(nickname: "test", email: "", password: "aaaaaa")
		  		@user.save
		  		expect(@user).to be_invalid
		  	end
		  	it "メールアドレスが重複していたら登録できない" do
		  		@user1 = User.create(nickname: "tes", email: "tes@mail", password: "aaaaaa")
		  		@user2 = User.create(nickname: "taro", email: "tes@mail", password: "aaaaaa")
		  		expect(@user2).to be_invalid
		  	end
		  	it "パスワードがなければ登録できない" do
		  		@user = User.new(nickname: "test", email: "tes@mail", password: "")
		  		expect(@user).to be_invalid
		  	end
		end
	end
end
