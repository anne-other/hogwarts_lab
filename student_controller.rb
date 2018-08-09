require('sinatra')
require('sinatra/contrib/all')

require_relative('./models/student.rb')
also_reload('./models/*')

#INDEX
get '/students' do
  @students = Student.all()
  erb (:index)
end

#NEW
get '/student/new' do
  erb (:new)
end
