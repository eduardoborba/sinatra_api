require "./spec/spec_helper"

RSpec.describe BookApi do
  def app
    BookApi
  end

  describe "GET books" do      
    context "with books" do      
      it "returns the books" do
        get "/books"
        
        expect(last_response.body).to eq("[]")
        expect(last_response.status).to eq 200
      end
    end
  end
end