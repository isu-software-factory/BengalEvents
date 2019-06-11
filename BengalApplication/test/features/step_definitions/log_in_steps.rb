


Given ("User enters their {string} and {string}") do |username, password|
  @username = username
  @password = password
end

When ("User clicks the submit button") do
  # return user and bool access
  @user, @authorize = check_log_in(@username, @password)
  # Access status
  @access_status = ""
  if @authorize
    @access_status = "Access Granted"
  else
    @access_status = "Access Denied"
  end
end

Then ("User will recieve a {string} notification back") do |answer|
  # If user has access then they will have "Access Granted"
  # If user doesn't have access then they will have "Access Denied"
  expect(@access_status).to eq(answer)
end