require 'rails_helper'

RSpec.describe User, type: :model do

	describe "ユーザーの登録" do

		let(:user){ User.create(params) }
		let(:params){{nickname: "tes", email: "tes@mail", password: "aaaaaa"}}

		context "登録の成功" do
		  	it "ニックネームとメールアドレスとパスワードがあれば登録できる" do
		  		expect(user).to be_valid
		  	end
		end

		context "登録の失敗" do

			subject{ user.to be_invalid}

		  	it "名前がなければ登録できない" do
		  		params[:nickname] = ""
		  	end
		  	it "メールアドレスがなければ登録できない" do
		  		params[:email] = ""
		  	end
		  	it "メールアドレスが重複していたら登録できない" do
		  		@user1 = user
		  		@user2 = User.create(nickname: "taro", email: "tes@mail", password: "aaaaaa")
		  		expect(@user2).to be_invalid
		  	end
		  	it "パスワードがなければ登録できない" do
		  		params[:password] = ""
		  	end
		end
	end
end
