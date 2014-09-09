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
    sequence(:name) {|n| "Write Use Case No #{n}"}
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

  factory :step, aliases: [:standard] do
    sequence(:custom_id) {|n| "1.#{n}"}
    state "defined"
    description "Step description for user case" 
    type "Norm"
    use_case
    slice
  end


  factory :slice do
    priority 1
    workflow_state "Scoped"
    estimate "10"
    #release - to be implemented
    order_priority 1
    project
  end

  #   use_case_id: 1
#   priority: 1
#   workflow_state: MyString
#   estimate: MyString
#   release_id: 1
#   order_priority: 1




	
end