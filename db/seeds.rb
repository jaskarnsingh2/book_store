# Ensure only one AdminUser is created in development
unless AdminUser.exists?(email: 'admin@example.com')
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

# Ensure About and Contact pages exist
Page.create(title: "About", content: "This is the About page.") unless Page.exists?(title: "About")
Page.create(title: "Contact", content: "This is the Contact page.") unless Page.exists?(title: "Contact")

# Create provinces
["Ontario", "Quebec", "British Columbia", "Manitoba"].each do |province_name|
  Province.create(name: province_name) unless Province.exists?(name: province_name)
end

# Create test users
province = Province.first
[{ email: 'user1@example.com', username: 'jass1' },
 { email: 'user2@example.com', username: 'jass2' }].each do |user_data|
  unless User.exists?(email: user_data[:email])
    User.create!(email: user_data[:email], password: 'password123', username: user_data[:username], province: province)
  end
end

# Create authors
authors = [
  { name: "Harper Lee", biography: "Author of To Kill a Mockingbird" },
  { name: "George Orwell", biography: "Author of 1984" },
  { name: "Herman Melville", biography: "Author of Moby Dick" },
  { name: "F. Scott Fitzgerald", biography: "Author of The Great Gatsby" },
  { name: "Jane Austen", biography: "Author of Pride and Prejudice" },
  { name: "Leo Tolstoy", biography: "Author of War and Peace" },
  { name: "J.D. Salinger", biography: "Author of The Catcher in the Rye" },
  { name: "J.R.R. Tolkien", biography: "Author of The Hobbit" },
  { name: "Aldous Huxley", biography: "Author of Brave New World" },
  { name: "Paulo Coelho", biography: "Author of The Alchemist" },
  { name: "J.K. Rowling", biography: "Author of Harry Potter" },
  { name: "Fyodor Dostoevsky", biography: "Author of Crime and Punishment" },
  { name: "Markus Zusak", biography: "Author of The Book Thief" },
  { name: "Emily Brontë", biography: "Author of Wuthering Heights" },
  { name: "Charlotte Brontë", biography: "Author of Jane Eyre" },
  { name: "C.S. Lewis", biography: "Author of The Chronicles of Narnia" },
  { name: "Mary Shelley", biography: "Author of Frankenstein" },
  { name: "Khaled Hosseini", biography: "Author of The Kite Runner" },
  { name: "Margaret Atwood", biography: "Author of The Handmaid's Tale" },
  { name: "Suzanne Collins", biography: "Author of The Hunger Games" }
]

authors.each do |author|
  Author.create!(author) unless Author.exists?(name: author[:name])
end

# Create books (100 books)
books = []
100.times do |i|
  books << {
    title: "Book Title #{i + 1}",
    author_id: rand(1..authors.size),
    genre: ["Fiction", "Dystopian", "Fantasy", "Adventure", "Romance", "Historical"].sample,
    price: rand(10.0..50.0).round(2) # Assign a random price between $10 and $50
  }
end

# Create books
books.each do |book|
  Book.create!(book) unless Book.exists?(title: book[:title])
end
# Create categories
categories = ["Fiction", "Non-fiction", "Fantasy", "Adventure", "Romance", "Mystery"]
categories.each do |category|
  Category.create!(name: category) unless Category.exists?(name: category)
end

# Assign categories to books
Book.all.each do |book|
  book.categories << Category.order("RANDOM()").limit(2) # Assign random categories
end