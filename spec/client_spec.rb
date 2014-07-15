describe "MotionOcean::Client" do
  describe "#access_token" do
    before do
      @token ||= "some_token"
    end
  
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
end