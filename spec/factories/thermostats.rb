FactoryGirl.define do
    factory :thermostat do
      household_token { Faker::Lorem.word }
      location { Faker::Address.name }
    end
  end