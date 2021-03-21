require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe "新規登録/ユーザー情報" do
    context '新規登録できるとき' do
      it 'ニックネームとメールアドレス、パスワードとパスワード(確認用)、名字と名前、名字と名前のフリガナ、生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'パスワードは半角英数字が混合されていれば登録できる' do
        @user.password = "aaa111"
        @user.password_confirmation = "aaa111"
        expect(@user).to be_valid
      end
      it 'パスワードとパスワード(確認用)が6文字以上であれば登録できる' do
        @user.password = "aaa111"
        @user.password_confirmation = "aaa111"
        expect(@user).to be_valid
      end
      it '本人確認は全角で入力されていれば登録できる' do
        @user.last_name = "山田"
        @user.first_name ="たろウ"
        expect(@user).to be_valid
      end
      it '本人確認のフリガナは全角(カタカナ)で入力されていれば登録できる' do
        @user.last_name_kana = "ヤマダ"
        @user.first_name_kana = "タロウ"
        expect(@user).to be_valid
      end
      
    end
    context '新規登録できないとき' do
      it 'ニックネームが空では登録できないこと' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空では登録できないこと' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したメールアドレスが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'メールアドレスに、@が含まれていない場合登録できないこと' do
        @user.email = "testaddress"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'パスワードが空では登録できないこと' do
        @user.password = ""
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードとパスワード(確認用)が5文字以下では登録できないこと' do
        @user.password = "aaa11"
        @user.password_confirmation = "aaa11"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードに全角文字が含まれる場合登録できないこと' do
        @user.password = "ああああああ"
        @user.password_confirmation = "ああああああ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードに記号が含まれている場合登録できないこと' do
        @user.password = "aaa11/"
        @user.password_confirmation = "aaa11/"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードに半角数字のみの場合登録できないこと' do
        @user.password = "111111"
        @user.password_confirmation = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'パスワードが存在してもパスワード(確認用)が空では登録できないこと' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードとパスワード(確認用)の値が一致していない場合登録できないこと' do
        @user.password = "111111"
        @user.password_confirmation = "222222"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '本人確認の名字が空では登録できないこと' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '本人確認の名前が空では登録できないこと' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '本人確認の名字が半角で入力されている場合登録できない' do
        @user.last_name = "aaｱｱ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it '本人確認の名前が半角で入力されている場合登録できない' do
        @user.first_name = "aaｱｱ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'フリガナの名字が空では登録できないこと' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'フリガナの名前が空では登録できないこと' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'フリガナの名字が半角で入力されている場合登録できない' do
        @user.last_name_kana = "ｱｱｱ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it 'フリガナの名前が半角で入力されている場合登録できない' do
        @user.first_name_kana = "ｱｱｱ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

    end
  end
end
