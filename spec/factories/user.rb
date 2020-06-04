FactoryBot.define do 
  factory :core_user, class: User do 
    id { 1 } 
    name { "core" }
    password_digest { "" }
  end
  factory :user2, class: User do 
    id { 2 }
    name { "Teste" }
    password_digest { "455667" }
  end
  factory :user3, class: User do 
    id { 3 }
    name { "Teste2" }
    password_digest { "455667" }
  end
end