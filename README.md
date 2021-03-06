cases
=====

Requirements Gathering based on an adaption of Use Case Essentials

Demo : [Cases 2.0 on Heroku](http://usecase.herokuapp.com/) - user: user@usecases.local; pass: password

If you intend to run this locally, follow the steps below

1. git clone https://github.com/adesakin/cases
2. Update config/database.yml file to match details of your database. Using postgres but any database will do as long as you have the database gem bundled.
3. bundle install
4. rake db:create && rake db:migrate && rake db:seed
5. rails s (I actually used -p 3002 during development and is referenced by test_helper file)
6. Log into http://localhost:300 with user: admin@cases.local pw: use.case. This was set in the db/seeds.yml file and can be changed before running step 4. Alternatively rails c and reset the password from there.


Brief
=====

It is a challenge agreeing on the best approach to use in gathering requirements for an Agile Project. Debates keep going on about user stories or use cases. In my experience developing Ruby on Rails applications, user stories are a bliss but arranging those cards and making a whole sense of the whole application can easily become inundating. Though still learning from every project experience, I seem to favour a merge between user stories and use cases (really not forcy about the diagrams because the development workflow is really in the use case descriptions). And the closest fit to this is Use Case Essential.

Ivar Jacobson came up with [Use Case Essentials 2.0](http://www.ivarjacobson.com/Use_Case2.0_ebook/) which I have been banging my head against ever so often, just to try break it down and make it simpler to use for lesser mortals. And this is my attempt to have it implemented.

Let's just try to apply a similar idea in developing this application by identifiying the critical use cases.

- [x] Sign in on cases (note that this would easily translate to 'As a user I want to Sign in on cases' in user stories)
- [x] Access Projects
- [x] Access Use Cases
- [x] Manage Members
- [x] Manage Use Cases Documents
- [x] Slice Use Cases
- [ ] Prepare and Analyze Use Case Slice
- [ ] Inspect and Adapt Use Case Slice

Not yet analyzed steps 6 - 8 above but will delve deep into them when I reach there. Beauty of Agile!

Now let's get going.
