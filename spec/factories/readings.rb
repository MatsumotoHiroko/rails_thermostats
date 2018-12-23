FactoryGirl.define do
    factory :reading do
        association :thermostat, factory: :thermostat
        temperature { Faker::Number.decimal(2, 3) }
        humidity { Faker::Number.decimal(2, 3) }
        battery_charge { Faker::Number.decimal(2, 3) }
    end
end