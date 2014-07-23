describe "MotionOcean::API::Client" do
  before do
    @base_url = 'http://httpbin.org/'
    @base_url_no_slash = 'http://httpbin.org'
    @token = 'some_test_token'
  end
  
  it "accepts a base URL and a block" do
    client = MotionOcean::API::Client.new(@base_url) do
      
    end
    
    client.base_url.should != nil
    client.base_url.absoluteString.should == @base_url
  end
  
  it "adds a slash to the base_url if it is not present" do
    client = MotionOcean::API::Client.new(@base_url_no_slash) do
      
    end
    
    client.base_url.should != nil
    client.base_url.absoluteString.should == @base_url
  end
  
  it "accepts headers" do
    client = MotionOcean::API::Client.new(@base_url_no_slash) do
      header 'Accept', 'application/json'
    end
    
    headers = client.instance_variable_get(:@headers)
    
    headers.should != nil
    headers.empty?.should == false
    headers.first[:name].should == 'Accept'
    headers.first[:value].should == 'application/json'
  end
  
  it "sets authorization headers" do
    client = MotionOcean::API::Client.new(@base_url_no_slash) do
      authorization token: 'some_test_token'
    end
    
    headers = client.instance_variable_get(:@headers)
    
    headers.should != nil
    headers.empty?.should == false
    
    headers.first[:name].should == 'Authorization'
    headers.first[:value].should == "Token #{@token}"
  end
end