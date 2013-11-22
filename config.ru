# encoding: utf-8
require 'erb'
require 'csv'

HISTORY = [
  ['2013-05-01', 1400],
  ['2013-05-02', 4400],
  ['2013-05-03', 1200],
  ['2013-05-04', 400],
  ['2013-05-05', 3000],
  ['2013-05-06', 700],
]

run ->(env){
  request = Rack::Request.new(env)
  path = request.path[1..-1]
  path = 'index' if path.empty?
  
  case path
    when 'index','home','history' then
      Rack::Response.new ERB.new(open("#{path}.html.erb").read).result(binding)
    when 'login' then
      is_success = request.POST['user'] == 'user' && request.POST['pass'] == 'pass'
      Rack::Response.new do |r|
        r.redirect is_success ? '/home' : '/'
      end
    when 'download_csv' then
      Rack::Response.new do |r|
        r['Content-Type'] = 'text/csv'
        r['Content-Disposition'] = %[attachment; filename="history.csv"]
        r.write CSV.generate{|csv| HISTORY.each{|row| csv << row}}
      end
    else
      Rack::Response.new ''
  end
}
