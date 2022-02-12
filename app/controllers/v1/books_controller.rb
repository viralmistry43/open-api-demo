
module V1
  class BooksController < ApplicationController

    before_action :set_book, only: %i[show update destroy]
    before_action :book_filter, only: :index

    def index
      @books = Book.where(@conditions)
      json_response({ entries: @books })
    end

    def show
      json_response(@book)
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        successful_post(@book.id)
      else
        unprocessable_entity(@book.errors.full_messages.join(', '))
      end
    end

    def update
      if @book.update(book_params)
        successful_put
      else
        unprocessable_entity(@book.errors.full_messages.join(', '))
      end
    end

    def destroy
      @book.destroy
      successful_response('Record Deleted Successfully')
    end

    private

    def set_book
      @book = Book.find_by(id: params[:id])
      not_found if @book.blank?
    end

    def book_params
      params.permit(:title, :author, :published_date, :total_pages)
    end

    def book_filter
      @conditions = {}
      @conditions[:title] = params[:title] if params[:title].present?
      @conditions[:author] = params[:author] if params[:title].present?
    end
  end
end
