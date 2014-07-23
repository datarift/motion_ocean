describe "MotionOcean::API::Authorization" do
  before do
    @token = 'some_token'
    @token_name = 'FooBar'
    @username = 'foo'
    @password = 'bar'
    @auth_data = 'Zm9vOmJhcg=='
  end
  
  it "creates a token-based auth header" do
    header_value = MotionOcean::API::Authorization.build(token: @token)
    
    header_value.should == "Token #{@token}"
  end
  
  it "uses the specified token_name" do
    header_value = MotionOcean::API::Authorization.build(token: @token, token_name: @token_name)
    
    header_value.should == "#{@token_name} #{@token}"
  end
  
  it "accepts HTTP Basic parameters" do
    header_value = MotionOcean::API::Authorization.build(username: @username, password: @password)
    
    header_value.should == "Basic #{@auth_data}"
  end
end