require "rails_helper"

RSpec.describe V1::CoinBlockchainsController do

  describe "mine block" do
    it "responds with the new block and a link to the new blockchain file" do
      create(:transaction)
      post "mine_block"
      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)).to eq({ "creation" => "ok", "block_id" => CoinBlockchain.last.id })
    end

    it "responds with an amount error" do
      post "mine_block"
      expect(JSON.parse(response.body)).to eq({ "creation" => "error" })
      expect(response.status).to eq(401)
    end
  end

  describe "add user" do
    it "creates a new user" do
      expect(User).to receive(:create)
        .with({name: "bla"})
        .and_return(User.new)
      
      post "add_user", params: { name: "bla" }
    end

    it "responds an error" do
      allow(User).to receive(:create).and_return(nil)
      post "add_user", params: { name: "bla" }
      expect(JSON.parse(response.body)).to eq({ "creation" => "error" })
    end
  end

  describe "add node" do
    it "creates a new node" do
      expect(Node).to receive(:create)
        .with({ port: "5", url: "url.com" })
        .and_return(Node.new)

      post "add_node", params: { port: "5", url: "url.com" }
    end
  end
end