require "./spec/spec_helper"

RSpec.describe BookApi do
  def app
    BookApi
  end
  
  before do
    Book.destroy_all

    @book = Book.create!(
      title: 'Book Title',
      author: 'John Doe',
      isbn: '1234567890'
    )
  end

  describe "GET books" do 
    it "returns the books serialized" do
      get "/books"
      
      expect(last_response.status).to eq 200
      expect(last_response.body).to eq([BookSerializer.new(@book).as_json].to_json)
    end
  end

  describe "POST books" do 
    it "creates a new book" do
      post "/books", {
        title: 'Second Book',
        author: 'Xin Zhong',
        isbn: '00234567189'
      }.to_json
      
      expect(last_response.status).to eq 201
      
      second_book = Book.find_by(title: 'Second Book')
      expect(last_response.headers['Location']).to eq("http://example.org/api/v1/books/#{second_book.id}")
    end
  end

  describe "GET books/:id" do 
    it "returns the book with the correct id" do
      get "/books/#{@book.id}"
      
      expect(last_response.status).to eq 200
      expect(last_response.body).to eq(BookSerializer.new(@book).as_json.to_json)
    end
  end

  describe "PATCH books/:id" do 
    it "updates the book attributes" do
      patch "/books/#{@book.id}", {
        title: 'Updated Title',
        author: 'John Doe',
        isbn: '1234567890'
      }.to_json
      
      expect(last_response.status).to eq 200
      
      @book.reload
      expect(@book.title).to eq('Updated Title')
    end
  end

  describe "DELETE books/:id" do 
    it "deletes the book" do
      delete "/books/#{@book.id}"
      
      expect(last_response.status).to eq 204
    end
  end
end