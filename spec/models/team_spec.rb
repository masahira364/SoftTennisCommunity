require 'rails_helper'

RSpec.describe Team, type: :model do
  
  describe "チームの作成" do

  	let(:user){Team.create(params)}
  	let(:params){{name: "test", slogan: "test", prefecture_code: 1,
  								postal_code: 1111111, address: "test", annual_fee: 1,
  								entry_fee: 1, members_wanted: true}}

  	context "作成成功" do

  		it "チーム名、スローガン、都道府県、郵便番号、住所、年会費、参加費、募集ステータスを入力" do
  			expect(user).to be_valid
  		end
  	end

  	context "作成失敗" do
  		# バリデーションのテスト
  		subject {user.to be_invalid}

  		it "チーム名が未入力" do
  			params[:name] = ""
  		end
  		it "スローガンが未入力" do
  			params[:slogan] = ""
  		end
  		it "都道府県が未入力" do
  			params[:prefecture_code] = ""
  		end
  		it "郵便番号が未入力" do
  			params[:postal_code] = ""
  		end
  		it "住所が未入力" do
  			params[:address] = ""
  		end
  		it "年会費が未入力" do
  			params[:annual_fee] = ""
  		end
  		it "参加費が未入力" do
  			params[:entry_fee] = ""
  		end
  		it "募集ステータスが未入力" do
  			params[:members_wanted] = ""
  		end
  	end
  end
end
