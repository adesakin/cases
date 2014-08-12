FactoryGirl.define do
  factory :user do
  	ignore do 
      username "foo"
    end
  	#username "foo"
  	email { "#{username}@test.cases.com" } 

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

	
end