Before do
  DatabaseCleaner.start

  begin
    page.driver.browser.switch_to.alert.accept
  rescue Selenium::WebDriver::Error::NoAlertOpenError
  end
end

After do |scenario|
  begin
    page.driver.browser.switch_to.alert.accept
  rescue Selenium::WebDriver::Error::NoAlertOpenError
  end

  DatabaseCleaner.clean
end