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
end

get('/surveys/:id') do
  @survey = Survey.find(params.fetch("id").to_i())
  @questions = Question.all()
  erb(:surveys)
end

post('/add_question') do
  ask = params.fetch("ask")
  @survey = Survey.find(params.fetch("survey_id").to_i())
  Question.create({:ask => ask, :survey_id => (params.fetch("survey_id"))})
  erb(:surveys)
end

patch('survey/edit_or_delete') do
  name = params.fetch('name')
  @survey = Survey.find(params.fetch("survey_id").to_i())
  @survey.update({:name => name})
  @surveys = Survey.all()
  redirect('/')
  erb(:edit_survey)
end

delete('survey/edit_or_delete') do
  @survey = Survey.find(params.fetch("survey_id").to_i())
  @survey.destroy()
  redirect('/')
  erb(:edit_survey)
end
