FactoryGirl.define do
  factory :poc, class: PointOfContact do
    # association :vendor
    sequence(:name) { |i| "Contact #{i}" }
    # name "contact name"
    # email "email example"
    sequence(:email) { |i| "contact#{i}@example.com" }
    phone "1(222)333-4444"
    contact_type "Admin"
    sequence(:id) { |i| i }

    factory :poc1 do
      name "poc1"
    end

    factory :poc2 do
      name "poc2"
    end

  end
end