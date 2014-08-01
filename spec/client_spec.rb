describe "MotionOcean::Client" do
  before do
    @token ||= "some_token"
  end
  
  describe "class" do
    it "is the right class" do
      client = MotionOcean::Client.new(access_token: @token)
      client.should.be.kind_of(MotionOcean::Client)
    end
  end

  describe "#access_token" do
    it "can be set via a hash" do
      client = MotionOcean::Client.new(access_token: @token)
      expect(client.access_token).to eq(@token)
    end
    
    it "can be set via a block" do
      client = MotionOcean::Client.new do |c|
        c.access_token = @token
      end
      
      expect(client.access_token).to eq(@token)
    end
    
    context "when none given" do
      it "fails" do
        expect { MotionOcean::Client.new }.to raise_error(ArgumentError, 'missing access token')
      end
    end
    
  end
  
  describe "operation" do
    it "can call the API" do
      client = MotionOcean::Client.new(access_token: ENV['DO_API_TOKEN'])
      client.should != nil
    
      client.domain.all do |response|
        expect(response).not_to be_nil
        expect(response.success?).to be_true
        expect(response.error).to be_nil
        response.data.should.be.kind_of(Hash)
      
        resume
      end
    
      wait_max(10) {}
    end
  end
end