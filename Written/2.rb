class Book
	attr_accessor :title
	attr_reader :author
	attr_writer :isbn, :publisher
  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end
end

book = Book.new('Frankenstein', 'mary shelley', 123456789)

p book.title # Frankenstein
book.title += ': The Modern Promethius'
p book.title # Frankenstein: The Modern Promethius
p book.author # mary shelley
# book.author = 'Mary Wollstonecraft Shelley' # NoMethodError
# p book.isbn # NoMethodError
book.isbn = 98765432
# p book.publisher # NoMethodError
book.publisher = 'Simon & Schuster'
p book #<Book:0x00007f6f16fb8470 @title="Frankenstein: The Modern Promethius", @author="mary shelley", @isbn=98765432, @publisher="Simon & Schuster">
