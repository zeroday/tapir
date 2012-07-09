This branch is in the middle of a refactor for mongo. most / all of the model fields have been ported to mongo keys, but the relationships are a total mess. mongo seems to have significantly less complex relationships / or at least you don't need to specify ids in the database for them? not sure. needs investigation. 

jcran@machine:~/pentestify/projects/tapir:ruby-1.9.3@tapir: (mongo)$ rails c
/Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/activerecord-3.2.1/lib/active_record/base.rb:681:in `<class:Base>': uninitialized constant ActiveRecord::Persistence (NameError)
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/activerecord-3.2.1/lib/active_record/base.rb:330:in `<module:ActiveRecord>'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/activerecord-3.2.1/lib/active_record/base.rb:33:in `<top (required)>'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/datatables-1.0.0/lib/datatables/engine.rb:2:in `require'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/datatables-1.0.0/lib/datatables/engine.rb:2:in `<top (required)>'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/datatables-1.0.0/lib/datatables.rb:2:in `require'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/datatables-1.0.0/lib/datatables.rb:2:in `<module:Datatables>'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/datatables-1.0.0/lib/datatables.rb:1:in `<top (required)>'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@global/gems/bundler-1.1.4/lib/bundler/runtime.rb:68:in `require'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@global/gems/bundler-1.1.4/lib/bundler/runtime.rb:68:in `block (2 levels) in require'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@global/gems/bundler-1.1.4/lib/bundler/runtime.rb:66:in `each'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@global/gems/bundler-1.1.4/lib/bundler/runtime.rb:66:in `block in require'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@global/gems/bundler-1.1.4/lib/bundler/runtime.rb:55:in `each'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@global/gems/bundler-1.1.4/lib/bundler/runtime.rb:55:in `require'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@global/gems/bundler-1.1.4/lib/bundler.rb:119:in `require'
	from /Volumes/untitled/work/pentestify/projects/tapir/config/application.rb:11:in `<top (required)>'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/railties-3.2.1/lib/rails/commands.rb:39:in `require'
	from /Users/jcran/.rvm/gems/ruby-1.9.3-p194@tapir/gems/railties-3.2.1/lib/rails/commands.rb:39:in `<top (required)>'
	from script/rails:6:in `require'
	from script/rails:6:in `<main>'