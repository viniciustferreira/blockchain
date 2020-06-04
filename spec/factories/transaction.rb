FactoryBot.define do 
  factory :transaction, class: Transaction do 
    before(:create) do
      create(:core_user)
      create(:user2)
    end

    sender_id { 1 }
    receiver_id { 2 }
    amount { "2000" }
  end
end