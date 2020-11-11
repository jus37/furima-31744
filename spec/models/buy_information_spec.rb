require 'rails_helper'

RSpec.describe BuyInformation, type: :model do
  before do
    @seller = FactoryBot.create(:user)
    @buyer = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @seller.id)
    @order = FactoryBot.build(:buy_information, user_id: @buyer.id, item_id: @item.id)
  end
  describe '商品購入機能' do
    context '購入機能がうまくいくとき' do
      it 'すべてただしく入力されている' do
        expect(@order).to be_valid
      end
      it '建物名が空でも保存できる' do
        @order.building_name = ''
        expect(@order).to be_valid
      end
    end
    context '購入機能がうまくいかないとき' do
      it '郵便番号が空白である' do
        @order.postnumber = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Postnumber can't be blank", 'Postnumber is invalid')
      end
      it '郵便番号が正しい方法で入力されていない' do
        @order.postnumber = '1111111'
        @order.valid?
        expect(@order.errors.full_messages).to include('Postnumber is invalid')
      end
      it '都道府県が---で入力されている' do
        @order.area_id = '0'
        @order.valid?
        expect(@order.errors.full_messages).to include('Area must be other than 0')
      end
      it '市区町村が空白である' do
        @order.area_town = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Area town can't be blank")
      end
      it '番地が空白である' do
        @order.area_street = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Area street can't be blank")
      end
      it '電話番号が空白である' do
        @order.telephonenumber = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Telephonenumber can't be blank", 'Telephonenumber is invalid')
      end
      it '電話番号が12桁以上である' do
        @order.telephonenumber = '123456789012'
        @order.valid?
        expect(@order.errors.full_messages).to include('Telephonenumber is too long (maximum is 11 characters)')
      end
      it '電話番号に数字以外が含まれている' do
        @order.telephonenumber = '111-111-111'
        @order.valid?
        expect(@order.errors.full_messages).to include('Telephonenumber is invalid')
      end
      it 'トークンが空である' do
        @order.token = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
