require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザ新規登録' do
    context '新規登録がうまくいくとき' do
      it "全項目が正しく入力されている" do
        expect(@user).to be_valid
      end
      it "パスワードが6文字以上かつ英字数字どちらも入力されていればで登録できる" do
        @user.password ="abc123"
        @user.password_confirmation = "abc123"
        expect(@user).to be_valid
      end
      it "名前が全角であれば登録できる" do
        @user.first_name ="山田"
        @user.last_name = "太郎"
        expect(@user).to be_valid
      end
      it "ふりがながカタカナ表記であれば登録できる" do
        @user.first_name_kana ="ヤマダ"
        @user.last_name_kana ="タロウ"
        expect(@user).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it "ニックネームが空である" do
        @user.nickname =""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "メールアドレスが空である" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "メールアドレスに＠が含まれていない" do
        @user.email = "aaacom"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "メールアドレスが既に登録されているものと重複している" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "パスワードが空である" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password can't be blank", "Password には英字と数字の両方を含めて設定してください", "Password confirmation doesn't match Password")
      end
      it "パスワードが5文字以下である" do
        @user.password = "aaaa1"
        @user.password_confirmation = "aaaa1"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "パスワードが英字のみである" do
        @user.password = "aaaaaa"
        @user.password_confirmation = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "パスワードが数字のみである" do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "パスワードとパスワード（確認用）が一致していない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "名前が空白である" do
        @user.first_name = ""
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name 全角文字を使用してください", "Last name can't be blank", "Last name 全角文字を使用してください")
      end
      it "名前が半角になっている" do
        @user.first_name = "ﾔﾏﾀﾞ"
        @user.last_name = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name 全角文字を使用してください", "Last name 全角文字を使用してください")
      end
      it "ふりがなが空白である" do
        @user.first_name_kana = ""
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana カタカナで入力してください", "Last name kana can't be blank", "Last name kana カタカナで入力してください")
      end
      it "ふりがながカタカナ以外で入力されている" do
        @user.first_name_kana = "やまだ"
        @user.last_name_kana = "たろう"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana カタカナで入力してください", "Last name kana カタカナで入力してください")
      end
      it "ふりがなが半角になっている" do
        @user.first_name_kana = "ﾔﾏﾀﾞ"
        @user.last_name_kana = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana カタカナで入力してください", "Last name kana カタカナで入力してください")
      end
      it "誕生日が空白である" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
