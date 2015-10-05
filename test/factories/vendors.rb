FactoryGirl.define do
  factory :vendor, class: Vendor do
    sequence(:name) { |i| "Tester #{i}" }

    factory :vendor_with_pocs do
      pocs { [FactoryGirl.build(:poc), FactoryGirl.build(:poc)] }
    end

    factory :vendor_empty_poc do
      pocs { [FactoryGirl.build(:poc_empty), FactoryGirl.build(:poc_empty)] }
    end

    factory :vendor_no_name do
      name ""
    end

    factory :vendor_repeat_name do
      name "repeat_me"
    end

    factory :vendor_empty_attributes do
      name nil
    end

    factory :vendor_with_pocs_attributes do
      pocs_attributes { [FactoryGirl.attributes_for(:poc), FactoryGirl.attributes_for(:poc)] }
    end

  end
end