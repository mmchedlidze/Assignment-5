//1-ი თასქი ბიბლიოთეკის სიმულაცია.
//1. შევქმნათ Class Book.
//Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
//Designated Init.
//Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
//Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს.
class Book {
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String, isBorrowed: Bool) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    
    func markAsBorrowed() {
            isBorrowed = true
        }

    func markAsReturned() {
            isBorrowed = false
        }
}


//2. შევქმნათ Class Owner
//Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
//Designated Init.
//Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
//Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი.

class Owner {
    var ownerID: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(ownerID: Int, name: String, borrowedBooks: [Book]) {
        self.ownerID = ownerID
        self.name = name
        self.borrowedBooks = borrowedBooks
    }
    func borrowBook(_ book: Book) {
        if !book.isBorrowed {
            book.markAsBorrowed()
            borrowedBooks.append(book)
            print("\(name) has borrowed '\(book.title)'.")
        } else {
            print("\(name) cannot borrow '\(book.title)' because it is already borrowed.")
        }
    }
    func returnBook(_ book: Book) {
        if let index = borrowedBooks.firstIndex(where: { $0.bookID == book.bookID }) {
            book.markAsReturned()
            borrowedBooks.remove(at: index)
            print("\(name) has returned '\(book.title)'.")
        } else {
            print("\(name) cannot return '\(book.title)' because it was not borrowed by \(name).")
        }
    }
}

//3. შევქმნათ Class Library
//Properties: Books Array, Owners Array.
//Designated Init.
//Method წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნებით.
//
//Method რომელიც ბიბლიოთეკაში ამატებს Owner-ს.
//
//Method რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს.
//
//Method რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს.
//
//Method რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს.
//
//Method რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ.
//
//Method რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია.

class Library {
    var books: [Book]
    var owners: [Owner]
    
    init(books: [Book], owners: [Owner]) {
        self.books = books
        self.owners = owners
    }
    
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func addOwner(_ owner: Owner) {
        owners.append(owner)
    }
    
    func isAvailable() -> [Book] {
        return books.filter { !$0.isBorrowed }
    }
    
    func isNotAvailable() -> [Book] {
        return books.filter { $0.isBorrowed }
    }
    
    func findUser(_ ownerID: Int) -> Owner? {
        return owners.first { $0.ownerID == ownerID
        }
    }
    
    func findBooksPerUser(_ ownerID: Int) -> [Book] {
        if let owner = owners.first(where: { $0.ownerID == ownerID }) {
            return owner.borrowedBooks
        } else {
            return []
        }
    }
    func borrowAvailableBook(_ bookTitle: String, from library: Library) {
           if let availableBook = library.isAvailable().first(where: { $0.title == bookTitle }) {
               print("User has successfully borrowed '\(book.title)'.")
           } else {
               print("\(book.title) can't be borrowed, because it is not available.")
           }
       }
}

//4. გავაკეთოთ ბიბლიოთეკის სიმულაცია.
//შევქმნათ რამოდენიმე წიგნი და რამოდენიმე Owner-ი, შევქმნათ ბიბლიოთეკა.

let user001 = Owner(ownerID: 1, name: "Nina", borrowedBooks: [])
let user002 = Owner(ownerID: 2, name: "Alex", borrowedBooks: [])
let user003 = Owner(ownerID: 3, name: "George", borrowedBooks: [])

let book = Book(bookID: 1, title: "Animal Farm", author: "George Orwell", isBorrowed: false)//borrowed,returned
let book1 = Book(bookID: 2, title: "1984", author: "George Orwell", isBorrowed: false)//borrowed,returned
let book2 = Book(bookID: 2, title: "To Kill a Mockingbird", author: "Harper Lee", isBorrowed: false)//borrowed
let book3 = Book(bookID: 3, title: "Pride and Prejudice", author: "Jane Austen", isBorrowed: false)//none
let book4 = Book(bookID: 4, title: "The Catcher in the Rye", author: "J.D. Salinger", isBorrowed: false)//borrowed

let library = Library(books: [], owners: [])

//დავამატოთ წიგნები და Owner-ები ბიბლიოთეკაში

library.addBook(book)
library.addBook(book1)
library.addBook(book2)
library.addBook(book3)
library.addBook(book4)
library.addOwner(user001)
library.addOwner(user002)
library.addOwner(user003)

//წავაღებინოთ Owner-ებს წიგნები და დავაბრუნებინოთ რაღაც ნაწილი.

user001.borrowBook(book1)
user001.borrowBook(book2)
user002.borrowBook(book)
user003.borrowBook(book1)
user003.borrowBook(book4)

user001.returnBook(book1)
user001.returnBook(book3)
user002.returnBook(book)

//დავბეჭდოთ ინფორმაცია ბიბლიოთეკიდან წაღებულ წიგნებზე, ხელმისაწვდომ წიგნებზე და გამოვიტანოთ წაღებული წიგნები კონკრეტულად ერთი Owner-ის მიერ.

print("Available Books:")
for book in library.isAvailable() {
    print("-", book.title)
}

print("Borrowed Books:")
for book in library.isNotAvailable() {
    print("-", book.title)
}

print("Nina has borrowed:")
for user in library.findBooksPerUser(1) {
    print("-", book.title)
}


