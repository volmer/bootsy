Before do
  DatabaseCleaner.start
end

After do |scenario|
  DatabaseCleaner.clean
end
