## [Chapter 1 - From zero to deploy](https://www.railstutorial.org/book/beginning)

### Foreword
- If you already know web development, this book will quickly teach you the essentials of the Rails framework, including MVC and REST, generators, migrations, routing, and embedded Ruby.
- The emphasis throughout the tutorial is on general principles, so you will have a solid foundation no matter what kinds of web applications you want to build.
- In this first chapter, we’ll get started with Ruby on Rails by installing all the necessary software and by setting up our development environment
- In Chapter 2, we’ll make a second project, whose purpose is to demonstrate the basic workings of a Rails application.
- The rest of the tutorial focuses on developing a single large real sample application (called sample_app), writing all the code from scratch. We’ll develop the sample app using a combination of mockups, test-driven development (TDD), and integration tests.
- We’ll get started in Chapter 3 by creating static pages and then add a little dynamic content.
- We’ll take a quick detour in Chapter 4 to learn a little about the Ruby language underlying Rails.
- Then, in Chapter 5 through Chapter 10, we’ll complete the foundation for the sample application by making a site layout, a user data model, and a full registration and authentication system (including account activation and password resets).
- Finally, in Chapter 11 and Chapter 12 we’ll add microblogging and social features to make a working example site.
- When writing a Ruby on Rails tutorial, it is tempting to rely on the scaffolding approach—it’s quicker, easier, more seductive. Following the scaffolding approach risks turning you into a virtuoso script generator with little (and brittle) actual knowledge of Rails.

### [1.1.1 Prerequisites](https://www.railstutorial.org/book/beginning#sec-prerequisites)
- There are no formal prerequisites to this book—the Ruby on Rails Tutorial contains integrated tutorials not only for Rails, but also for the underlying Ruby language, the default Rails testing framework (minitest), the Unix command line, HTML, CSS, a small amount of JavaScript, and even a little SQL.
- Recommend having some HTML and programming background before starting this tutorial.

### [1.1.2 Conventions in this book](https://www.railstutorial.org/book/beginning#sec-conventions)
- Each chapter in the tutorial includes exercises, the completion of which is optional but recommended.
- In order to keep the main discussion independent of the exercises, the solutions are not generally incorporated into subsequent code listings. In the rare circumstance that an exercise solution is used subsequently, it is explicitly solved in the main text.

### [1.2.1 Development environment](https://www.railstutorial.org/book/beginning#sec-development_environment)
- The three essential components needed to develop web applications: a text editor, a filesystem navigator, and a command-line terminal.
- The “Find in Files” global search can be considered essential to navigating any large Ruby or Rails project.
- Extra Development Settings for Sublime Text that are Awesome:
```
  "tab_size": 2,
  "translate_tabs_to_spaces": true,
  "trim_trailing_white_space_on_save": true,
  "ensure_newline_at_eof_on_save": true,
  "save_on_focus_lost": true,
  "scroll_past_end": true,
```

### [1.2.2 Installing Rails](https://www.railstutorial.org/book/beginning#sec-installing_rails)
```
$ gem install rails -v 4.2.2
```
- Here the -v flag ensures that the specified version of Rails gets installed, which is important to get results consistent with this tutorial.
```
Done installing documentation for i18n, thread_safe, tzinfo, activesupport, builder, erubis, mini_portile2,
nokogiri, rails-deprecated_sanitizer, rails-dom-testing, loofah, rails-html-sanitizer, actionview, rack,
rack-test, actionpack, globalid, activejob, mime-types-data, mime-types, mail, actionmailer, activemodel,
arel, activerecord, thor, railties, concurrent-ruby, sprockets, sprockets-rails, rails after 486 seconds
31 gems installed
```

### [1.3 The first application](https://www.railstutorial.org/book/beginning#sec-the_hello_application)
```
$ rails _4.2.2_ new hello_app
.
Bundle complete! 12 Gemfile dependencies, 55 gems now installed.
```
- This standard directory and file structure is one of the many advantages of Rails; it immediately gets you from zero to a functional (if minimal) application.
- Moreover, since the structure is common to all Rails apps, you can immediately get your bearings when looking at someone else’s code.

### [1.3.1 Bundler](https://www.railstutorial.org/book/beginning#sec-bundler)
- `gem 'uglifier', '>= 1.3.0'`
  - This installs the latest version of the uglifier gem as long as it’s greater than or equal to version 1.3.0—even if it’s, say, version 7.2.
- `gem 'coffee-rails', '~> 4.0.0'`
  - This installs the gem coffee-rails as long as it’s newer than version 4.0.0 and not newer than 4.1.
- In other words, the >= notation always installs the latest gem, whereas the ~> 4.0.0 notation only installs updated gems representing minor point releases (e.g., from 4.0.0 to 4.0.1), but not major point releases (e.g., from 4.0 to 4.1).
- `Bundle complete! 12 Gemfile dependencies, 58 gems now installed.`

### [1.3.2 rails server](https://www.railstutorial.org/book/beginning#sec-rails_server)
- Windows issues resolved:
  - `cannot load such file -- sqlite3/sqlite3_native (LoadError)` => [StackOverflow: Update gem to 1.3.11](http://stackoverflow.com/questions/17643897/cannot-load-such-file-sqlite3-sqlite3-native-loaderror-on-ruby-on-rails)
  - `cannot load such file -- pty (LoadError)` => [StackOverflow: Remove non-windows gem](http://stackoverflow.com/questions/26666690/rails-generate-controller-gives-me-load-error)
  - It works!
```
Started GET "/" for ::1 at 2016-04-05 23:12:28 -0600
Processing by Rails::WelcomeController#index as HTML
  Rendered C:/Ruby224/lib/ruby/gems/2.2.0/gems/railties-4.2.2
  /lib/rails/templates/rails/welcome/index.html.erb (5.0ms)
Completed 200 OK in 71ms (Views: 55.7ms | ActiveRecord: 0.0ms)
```

### [1.3.3 Model-View-Controller (MVC)](https://www.railstutorial.org/book/beginning#sec-mvc)
- Rails follows the model-view-controller (MVC) architectural pattern, which enforces a separation between “domain logic” (also called “business logic”) from the input and presentation logic associated with a graphical user interface (GUI).
- [Figure 1.11: A schematic representation of the model-view-controller (MVC) architecture.](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_3rd_edition/images/figures/mvc_schematic.png)

### [1.3.4 Hello, world!](https://www.railstutorial.org/book/beginning#sec-hello_world)
```
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def hello
    render text: "hello, world!"
  end
end
```
```
Rails.application.routes.draw do
  root 'application#hello'
end
```
- [Hello, world!](https://softcover.s3.amazonaws.com/636/ruby_on_rails_tutorial_3rd_edition/images/figures/hello_world_hello_app.png)

### [1.4 Version control with Git](https://www.railstutorial.org/book/beginning#sec-version_control)
- Version control systems allow us to track changes to our project’s code, collaborate more easily, and roll back any inadvertent errors (such as accidentally deleting files).
- Putting your source code under version control with Git is strongly recommended, not only because it’s nearly a universal practice in the Rails world.

### [1.4.1 Installation and setup](https://www.railstutorial.org/book/beginning#sec-git_setup)
```
$ git config --global user.name "Your Name"
$ git config --global user.email your.email@example.com
$ git config --global push.default matching
$ git config --global alias.co checkout
```
- The third line is included only to ensure forward-compatibility with an upcoming release of Git.
- The optional fourth line is included so that you can use co in place of the more verbose checkout command.
- [Try Git: Code School](https://try.github.io/)

### [1.4.2 What good does Git do you?](https://www.railstutorial.org/book/beginning#uid73)
- Suppose you’ve made some accidental changes, such as (D’oh!) deleting the critical app/controllers/ directory.
- A file has been deleted, but the changes are only on the “working tree”; they haven’t been committed yet.
- This means we can still undo the changes using the checkout command with the -f flag to force overwriting the current changes:
```
$ git checkout -f
$ git status
# On branch master
nothing to commit (working directory clean)
```

### [1.4.3 Bitbucket](https://www.railstutorial.org/book/beginning#sec-bitbucket)
- Note: this entire section cannot be broken down further. It's basically a full tutorial in-and-of itself.
- Previous editions of this tutorial used GitHub instead.  Since GitHub charges for private repositories while Bitbucket offers an unlimited number for free, for our purposes Bitbucket is a better fit than GitHub.

### [1.4.4 Branch, edit, commit, merge](https://www.railstutorial.org/book/beginning#sec-git_commands)
- Note: this entire section cannot be broken down further. It's basically a full tutorial in-and-of itself.
- Note: [GitHub Desktop](https://desktop.github.com/) is a handy tool.

### [1.5 Deploying](https://www.railstutorial.org/book/beginning#sec-deploying)
- Deploying Rails applications used to be a pain, but the Rails deployment ecosystem has matured rapidly in the past few years, and now there are several great options. These include shared hosts or virtual private servers running [Phusion Passenger](http://www.modrails.com/) (a module for the Apache and Nginx web servers), full-service deployment companies such as [Engine Yard](http://engineyard.com/) and [Rails Machine](http://railsmachine.com/), and cloud deployment services such as [Engine Yard Cloud](http://cloud.engineyard.com/) and [Heroku](http://heroku.com/).
- Heroku makes deploying Rails applications easy — as long as your source code is under version control with Git.
- For many purposes, including for this tutorial, Heroku’s free tier is more than sufficient.
- The rest of this section is dedicated to deploying our first application to Heroku.
