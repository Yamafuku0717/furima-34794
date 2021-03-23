FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@example' }
    password              { 'aaa111' }
    password_confirmation { password }
    first_name            { '山田' }
    first_name_kana       { 'ヤマダ' }
    last_name             { '太郎' }
    last_name_kana        { 'タロウ' }
    birth_date            { 1_990_621 }
  end
end
