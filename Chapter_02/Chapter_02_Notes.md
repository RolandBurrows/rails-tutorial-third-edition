## [Chapter 2 - A toy app](https://www.railstutorial.org/book/toy_app)

### [Foreword](https://www.railstutorial.org/book/toy_app#cha-a_toy_app)
- Scaffold generators create a large amount of functionality automatically.
- The resulting toy app will allow us to interact with it through its URLs, giving us insight into the structure of a Rails application, including a first example of the REST architecture favored by Rails.
- It will also consist of users and their associated microposts (thus constituting a minimalist Twitter-style app).

### [2.1 Planning the application](https://www.railstutorial.org/book/toy_app#sec-planning_the_application)
```
$ rails _4.2.2_ new toy_app
Bundle complete! 12 Gemfile dependencies, 55 gems now installed.
```
- [Updated gemfile to use](https://www.railstutorial.org/book/toy_app#code-demo_gemfile_sqlite_version_redux)
```
$ bundle install --without production
Bundle complete! 14 Gemfile dependencies, 58 gems now installed.
```
```
https://frozen-atoll-55751.herokuapp.com/
=> "I'm a toy app. Play with me!"
```
- The typical first step when making a web application is to create a data model, which is a representation of the structures needed by our application.
- In our case, the toy app will be a microblog, with only users and short (micro)posts. Thus, we’ll begin with a model for users of the app (Section 2.1.1), and then we’ll add a model for microposts (Section 2.1.2).

### [2.1.1 A toy model for users](https://www.railstutorial.org/book/toy_app#sec-modeling_demo_users)
- Users of our toy app will have:
  - A unique *integer* identifier called `id`
  - A publicly viewable `name` (of type *string*)
  - An `email` address (also a *string*) that will double as a username
- As we’ll see starting in Section 6.1.1, the label `users` corresponds to a table in a database, and the `id`, `name`, and `email` attributes are columns in that table.

### [2.1.2 A toy model for microposts](https://www.railstutorial.org/book/toy_app#sec-modeling_demo_microposts)
- A micropost has only an `id` and a `content` field for the micropost’s text (of type *text*).
- There’s an additional complication, though: we want to associate each micropost with a particular user. We’ll accomplish this by recording the `user_id` of the owner of the post.
- We’ll see in Section 2.3.3 (and more fully in Chapter 11) how this `user_id` attribute allows us to succinctly express the notion that a user potentially has many associated microposts.

### [2.2 The Users resource](https://www.railstutorial.org/book/toy_app#sec-demo_users_resource)
- We’ll implement the `users` data model, along with a web interface to that model. The combination will constitute a Users resource, which will allow us to think of users as objects that can be created, read, updated, and deleted (CRUD) through the web via the HTTP protocol.
- `$ rails generate scaffold User name:string email:string` => Success!
- `$ bundle exec rake db:migrate` => Success!
- Note that, in order to ensure that the command uses the version of Rake corresponding to our Gemfile, we need to run rake using `bundle exec`.
- In the Unix tradition, the `make` utility has played an important role in building executable programs from source code.
- Rake is "Ruby make", a make-like language written in Ruby. Rails uses Rake extensively, especially for the innumerable little administrative tasks necessary when developing database-backed web applications.

### [2.2.1 A user tour](https://www.railstutorial.org/book/toy_app#sec-a_user_tour)
- [Stack Overflow solution to "Rails ExecJS::ProgramError in Pages#home" issue (Windows)](http://stackoverflow.com/questions/28421547/rails-execjsprogramerror-in-pageshome)
  - [Specific advice, which does indeed work](http://stackoverflow.com/a/35965674)
```
http://localhost:3000/users/1
User was successfully created.
Name: Usor
Email: usor@usor.test
```
```
User was successfully updated.
Name: User
Email: user@user.test
```
```
User was successfully created.
Name: two-ser
Email: two-ser@user.test
```
```
User was successfully destroyed.
```

### [2.2.2 MVC in action](https://www.railstutorial.org/book/toy_app#sec-mvc_in_action)
- [A detailed diagram of MVC in Rails.](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_3rd_edition/images/figures/mvc_detailed.png)

Here is a summary of the steps shown in the diagram:

1. The browser issues a request for the `/users` URL.
2. Rails routes `/users` to the index action in the `Users` controller.
3. The index action asks the `User` model to retrieve all users (`User.all`).
4. The `User` model pulls all the users from the database.
5. The `User` model returns the list of users to the controller.
6. The controller captures the users in the `@users` variable, which is passed to the index view.
7. The view uses embedded Ruby to render the page as HTML.
8. The controller passes the HTML back to the browser.

And more notes:
- [Table: RESTful routes provided by the Users resource](https://www.railstutorial.org/book/toy_app#table-demo_RESTful_users)
- [REpresentational State Transfer (REST) primer](https://www.railstutorial.org/book/toy_app#aside-REST)
- Further reading: [Active Record](http://guides.rubyonrails.org/active_record_basics.html)

### [2.2.3 Weaknesses of this Users resource](https://www.railstutorial.org/book/toy_app#sec-weaknesses_of_this_users_resource)

Though good for getting a general overview of Rails, the scaffold `Users` resource suffers from a number of severe weaknesses:
- **No data validations.** Our `User` model accepts data such as blank names and invalid email addresses without complaint.
- **No authentication.** We have no notion of logging in or out, and no way to prevent any user from performing any operation.
- **No tests.** This isn’t technically true — the scaffolding includes rudimentary tests — but the generated tests don’t test for data validation, authentication, or any other custom requirements.
- **No style or layout.** There is no consistent site styling or navigation.

### [2.3 The Microposts resource](https://www.railstutorial.org/book/toy_app#sec-microposts_resource)
- Having generated and explored the `Users` resource, we turn now to the associated `Microposts` resource.
- The RESTful structure of Rails applications is best absorbed by this sort of repetition of form.
- Indeed, seeing the parallel structure of `Users` and `Microposts` even at this early stage is one of the prime motivations for this chapter.

### [2.3.1 A micropost microtour](https://www.railstutorial.org/book/toy_app#sec-a_micropost_microtour)
- `$ rails generate scaffold Micropost content:text user_id:integer`
- `$ bundle exec rake db:migrate`
- [Table: RESTful Microposts](https://www.railstutorial.org/book/toy_app#table-demo_RESTful_microposts)
- New Micropost:
```
Micropost was successfully created.
Content: First!
User: 1
```

### [2.3.2 Putting the micro in microposts](https://www.railstutorial.org/book/toy_app#sec-putting_the_micro_in_microposts)
- Any micropost worthy of the name should have some means of enforcing the length of the post. Implementing this constraint in Rails is easy with *validations*.
- To accept microposts with at most 140 characters (for example), we use a length validation:
```
app/models/micropost.rb
  class Micropost < ActiveRecord::Base
   validates :content, length: { maximum: 140 }
  end
```
- Rails renders error messages indicating that the micropost’s content is too long. (We’ll learn more about error messages in Section 7.3.3.).
```
1 error prohibited this micropost from being saved:
Content is too long (maximum is 140 characters)
```

### [2.3.3 A user has_many microposts](https://www.railstutorial.org/book/toy_app#sec-demo_user_has_many_microposts)
- One of the most powerful features of Rails is the ability to form *associations* between different data models. In the case of our `User` model, each user potentially has many microposts.
- We can examine the implications of the user-micropost association by using the `console`, which is a useful tool for interacting with Rails applications.
```
$ rails console
Loading development environment (Rails 4.2.2)
irb(main):001:0> first_user = User.first
  User Load (0.0ms)  SELECT  "users".* FROM "users"  ORDER BY "users"."id" ASC LIMIT 1
  => #<User id: 2, name: "one-ser", email: "one-ser@user.test", created_at: "2016-04-27 04:10:26", updated_at: "2016-05-01 02:53:51">
irb(main):002:0> first_user.microposts
  Micropost Load (0.0ms)  SELECT "microposts".* FROM "microposts" WHERE "microposts"."user_id" = ?  [["user_id", 2]]
  => #<ActiveRecord::Associations::CollectionProxy [#<Micropost id: 4, content: "12345678901234567890123456789012345678901234567890...", user_id: 2, created_at: "2016-04-30 20:59:55", updated_at: "2016-05-01 02:52:06">]>
irb(main):003:0> micropost = first_user.microposts.first
  => #<Micropost id: 4, content: "12345678901234567890123456789012345678901234567890...", user_id: 2, created_at: "2016-04-30 20:59:55", updated_at: "2016-05-01 02:52:06">
irb(main):004:0> micropost.user
  => #<User id: 2, name: "one-ser", email: "one-ser@user.test", created_at: "2016-04-27 04:10:26", updated_at: "2016-05-01 02:53:51">
```

### [2.3.4 Inheritance hierarchies](https://www.railstutorial.org/book/toy_app#sec-inheritance_hierarchies)
```
app/models/user.rb
 class User < ActiveRecord::Base
 end

app/models/micropost.rb
 class Micropost < ActiveRecord::Base
 end
```
- [Figure 2.16: The inheritance hierarchy for the User and Micropost models.](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_3rd_edition/images/figures/demo_model_inheritance.png)
```
app/controllers/users_controller.rb
 class UsersController < ApplicationController

app/controllers/microposts_controller.rb
 class MicropostsController < ApplicationController

app/controllers/application_controller.rb
 class ApplicationController < ActionController::Base
 ```
- [Figure 2.17: The inheritance hierarchy for the Users and Microposts controllers.](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_3rd_edition/images/figures/demo_controller_inheritance.png)
- As with model inheritance, both the `Users` and `Microposts` controllers gain a large amount of functionality by inheriting from a base class (in this case, `ActionController::Base`), including the ability to manipulate model objects, filter inbound HTTP requests, and render views as HTML.
- Since all Rails controllers inherit from `ApplicationController`, rules defined in the `Application` controller automatically apply to every action in the application. For example, in Section 8.4 we’ll see how to include helpers for logging in and logging out of all of the sample application’s controllers.

### [2.3.5 Deploying the toy app](https://www.railstutorial.org/book/toy_app#sec-deploying_the_toy_app)
- `$ git push heroku` (This assumes you created the Heroku app in Section 2.1. Otherwise, you should run heroku create and then git push heroku master.)
- To get the application’s database to work, you’ll also have to migrate the production database: `$ heroku run rake db:migrate`

### [2.4 Conclusion](https://www.railstutorial.org/book/toy_app#sec-toy_app_conclusion)
- We’ve come now to the end of the high-level overview of a Rails application. The toy app developed in this chapter has several strengths and a host of weaknesses.
- Strengths
  - Introduction to MVC
  - First taste of the REST architecture
  - Beginning data modeling
- Weaknesses
  - No static pages (such as “Home” or “About”)
  - No security
  - No meaningful tests

### [2.4.1 What we learned in this chapter](https://www.railstutorial.org/book/toy_app#sec-toy_app_what_we_learned_in_this_chapter)
- Scaffolding automatically creates code to model data and interact with it.
- Scaffolding is good for getting started quickly, but is bad for understanding.
- Rails uses the Model-View-Controller (MVC) pattern for structuring web applications.
- Rails supports data validations to place constraints on the values of data model attributes.
- Rails comes with built-in functions for defining associations between different data models.
- We can interact with Rails applications at the command line using the Rails console.

### [2.5 Exercises](https://www.railstutorial.org/book/toy_app#sec-toy_app_exercises)
1. Confirmed.
2. Confirmed.
