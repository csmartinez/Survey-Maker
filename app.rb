require("bundler/setup")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

post('/surveys') do
  name = params.fetch('name')
  @name = Survey.create({:name => name})
  redirect('/')
  erb(:index)
end

post('/surveys/:id') do
  ask = params.fetch("ask")
  @survey = Survey.find(params.fetch("id").to_i())
  @ask = Question.create({:ask => ask, :survey_id => (params.fetch("id"))})
  redirect('/surveys')
  erb(:surveys)
end

get('/surveys/:id') do
  @survey = Survey.find(params.fetch("id").to_i())
  @questions = Question.all()
  erb(:surveys)
end
