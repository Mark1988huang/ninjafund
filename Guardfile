guard :bundler do
  watch('Gemfile')
end

guard :rspec do
  watch 'spec/spec_helper.rb'
  watch %r{^spec/(.+)_spec\.rb$} 
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
end

guard :coffeescript, :all_on_start => true, :output => 'public/backbone' do
	watch %r{^app/(.+)\.coffee$}
end

guard :coffeescript, :all_on_start => true, :output => 'spec/javascripts' do
	watch %r{^spec/coffeescripts/(.+)\.coffee$}
end

guard 'jasmine-headless-webkit' do
	watch %r{^spec/(.+)_spec\.js$}
	watch(%r{^app/(.+)\.coffee$}) { |m| "spec/javascripts/#{m[1]}_spec.js" }
end

guard :cucumber do
  watch 'features/acceptance_helper.rb'
  watch %r{^features/(.+)\.feature$}
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end
