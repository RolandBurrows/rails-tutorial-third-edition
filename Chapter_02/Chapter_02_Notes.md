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
