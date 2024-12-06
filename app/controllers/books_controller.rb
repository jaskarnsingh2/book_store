class BooksController < ApplicationController
  def index
    @books = Book.joins(:author).includes(:author)

    # Apply keyword search (title or author name)
    if params[:query].present?
      @books = @books.where(
        "LOWER(books.title) LIKE ? OR LOWER(authors.name) LIKE ?",
        "%#{params[:query].downcase}%", "%#{params[:query].downcase}%"
      )
    end

    # Apply category filter
    if params[:category].present? && params[:category] != "All Categories"
      @books = @books.where("LOWER(books.genre) LIKE ?", "%#{params[:category].downcase}%")
    end
  end
  
end
