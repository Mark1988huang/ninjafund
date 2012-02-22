# watch the gemfile for changes and re-load on save
guard :bundler do
  watch('Gemfile')
end

# watch the specs and relevant library files
guard :rspec do
  watch( %r{^spec/(.+)_spec\.rb} )  
  watch( %r{^lib/(.+)\.rb}) { |m| "spec/#{m[1]}_spec.rb" }
end
