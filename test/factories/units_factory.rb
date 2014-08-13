FactoryGirl.define do
  factory :user do
  	ignore do 
      username "foo"
    end
  	#username "foo"
  	sequence(:email) { |n| "#{username}#{n}@test.cases.com" } 
    password "password"

  end

  factory :use_case do
    name "Write Use Case"
    description "As a user I want to write use case"
    standard_flow "1. Click on Create Use Case. 2. Fill in details including - name, description and standard flow"
    project
  end

  factory :project do
    name "Test Project"

  end

  factory :member do
    first_name "User FN"
    last_name "User SN"
    user
    factory :member_new do
      association :user, strategy: :build
    end
  end

  factory :piece do
    sequence(:name) {|n| "Document Number #{n}"}
  end
	
end