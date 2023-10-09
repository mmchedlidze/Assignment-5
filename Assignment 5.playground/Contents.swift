print("---Task 1---")
//1-ი თასქი ბიბლიოთეკის სიმულაცია.
//1. შევქმნათ Class Book.
//Properties: bookID(უნიკალური იდენტიფიკატორი Int), String title, String author, Bool isBorrowed.
//Designated Init.

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
//Method რომელიც ნიშნავს წიგნს როგორც borrowed-ს.
    func markAsBorrowed() {
            isBorrowed = true
        }
//Method რომელიც ნიშნავს წიგნს როგორც დაბრუნებულს.
    func markAsReturned() {
            isBorrowed = false
        }
}


//2. შევქმნათ Class Owner
//Properties: ownerId(უნიკალური იდენტიფიკატორი Int), String name, Books Array სახელით borrowedBooks.
//Designated Init.

class Owner {
    var ownerID: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(ownerID: Int, name: String, borrowedBooks: [Book]) {
        self.ownerID = ownerID
        self.name = name
        self.borrowedBooks = borrowedBooks
    }
//Method რომელიც აძლევს უფლებას რომ აიღოს წიგნი ბიბლიოთეკიდან.
    func borrowBook(_ book: Book) {
        if !book.isBorrowed {
            book.markAsBorrowed()
            borrowedBooks.append(book)
            print("\(name) has borrowed '\(book.title)'.")
        } else {
            print("\(name) cannot borrow '\(book.title)' because it is already borrowed.")
        }
    }
//Method რომელიც აძლევს უფლებას რომ დააბრუნოს წაღებული წიგნი.
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

class Library {
    var books: [Book]
    var owners: [Owner]
    
    init(books: [Book], owners: [Owner]) {
        self.books = books
        self.owners = owners
    }
//Method წიგნის დამატება, რათა ჩვენი ბიბლიოთეკა შევავსოთ წიგნებით.
    func addBook(_ book: Book) {
        books.append(book)
    }
//Method რომელიც ბიბლიოთეკაში ამატებს Owner-ს.
    func addOwner(_ owner: Owner) {
        owners.append(owner)
    }
//Method რომელიც პოულობს და აბრუნებს ყველა ხელმისაწვდომ წიგნს.
    func isAvailable() -> [Book] {
        return books.filter { !$0.isBorrowed }
    }
//Method რომელიც პოულობს და აბრუნებს ყველა წაღებულ წიგნს.
    func isNotAvailable() -> [Book] {
        return books.filter { $0.isBorrowed }
    }
//Method რომელიც ეძებს Owner-ს თავისი აიდით თუ ეგეთი არსებობს.
    func findUser(_ ownerID: Int) -> Owner? {
        return owners.first { $0.ownerID == ownerID
        }
    }
//Method რომელიც ეძებს წაღებულ წიგნებს კონკრეტული Owner-ის მიერ.
    func findBooksPerUser(_ ownerID: Int) -> [Book] {
        if let owner = owners.first(where: { $0.ownerID == ownerID }) {
            return owner.borrowedBooks
        } else {
            return []
        }
    }
//Method რომელიც აძლევს უფლებას Owner-ს წააღებინოს წიგნი თუ ის თავისუფალია.
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


print("---Task 2---")

//2 თასქი ავაწყოთ პატარა E-commerce სისტემა. (თავისი ქვეთასქებით).
//1. შევქმნათ Class Product,
//შევქმნათ შემდეგი properties productID (უნიკალური იდენტიფიკატორი Int), String name, Double price.
//შევქმნათ Designated Init.
class Product {
    var productID: Int
    var name: String
    var price: Double
    
    init(productID: Int, name: String, price: Double) {
        self.productID = productID
        self.name = name
        self.price = price
    }
}

//2. შევქმნათ Class Cart
//Properties: cartID(უნიკალური იდენტიფიკატორი Int), Product-ების Array სახელად items.
//შევქმნათ Designated Init.
class Cart {
    var cartID : Int
    var items : [Product]
    
    init(cartID: Int, items: [Product]) {
        self.cartID = cartID
        self.items = items
    }

//Method იმისათვის რომ ჩვენს კალათაში დავამატოთ პროდუქტი.
    func addProduct(_ product:Product ) {
        items.append(product)
    }
//Method იმისათვის რომ ჩვენი კალათიდან წავშალოთ პროდუქტი მისი აიდით.
    func removeProduct(_ product: Product) {
        if let index = items.firstIndex(where: { $0.productID == product.productID }) {
            items.remove(at: index)
            print("Item \(product.productID) was removed from Cart")
        } else {
            print("Item \(product.productID) was not found")
        }
    }
//Method რომელიც დაგვითვლის ფასს ყველა იმ არსებული პროდუქტის რომელიც ჩვენს კალათაშია.
    func countPrice() -> Double {
        var totalPrice: Double = 0.0
        
        for product in items {
            totalPrice += product.price
        }
        return totalPrice
    }
}
//3. შევქმნათ Class User
//Properties: userID(უნიკალური იდენტიფიკატორი Int), String username, Cart cart.
//Designated Init.
class User {
    var userID: Int
    var username: String
    var cart: Cart
    
    init(userID: Int, username: String, cart: Cart) {
        self.userID = userID
        self.username = username
        self.cart = cart
    }
   
//Method რომელიც კალათაში ამატებს პროდუქტს.
    func addProductToCart(_ product: Product) {
            cart.addProduct(product)
            print("\(username) has successfully added '\(product.name)' to their cart.")
        }
//Method რომელიც კალათიდან უშლის პროდუქტს.
    func removeProductFromCart(_ product: Product) {
            if let index = cart.items.firstIndex(where: { $0.productID == product.productID }) {
                cart.items.remove(at: index)
                print("\(username) has successfully removed '\(product.name)' from their cart.")
            } else {
                print("\(username) cannot remove '\(product.name)' because it is not in their cart.")
            }
        }
//Method რომელიც checkout (გადახდის)  იმიტაციას გააკეთებს დაგვითვლის თანხას და გაასუფთავებს ჩვენს shopping cart-ს.
    func checkout() -> Double {
           let totalPrice = cart.countPrice()
           print("\(username) paid $\(totalPrice) for the items in their cart.")
           cart.items.removeAll()
           return totalPrice
       }
}
//4. გავაკეთოთ იმიტაცია და ვამუშაოთ ჩვენი ობიექტები ერთად.
//
//შევქმნათ რამოდენიმე პროდუქტი.
//
//შევქმნათ 2 user-ი, თავისი კალათებით,
//
//დავუმატოთ ამ იუზერებს კალათებში სხვადასხვა პროდუქტები,
//
//დავბეჭდოთ price ყველა item-ის ამ იუზერების კალათიდან.
//
//და ბოლოს გავაკეთოთ სიმულაცია ჩექაუთის, დავაბეჭდინოთ იუზერების გადასხდელი თანხა და გავუსუფთაოთ კალათები.
//
//
let product1 = Product(productID: 1, name: "Product 1", price: 10.0)
let product2 = Product(productID: 2, name: "Product 2", price: 20.0)
let product3 = Product(productID: 3, name: "Product 3", price: 15.0)


let user1 = User(userID: 1, username: "User 1", cart: Cart(cartID: 1, items: []))
let user2 = User(userID: 2, username: "User 2", cart: Cart(cartID: 2, items: []))

user1.addProductToCart(product1)
user1.addProductToCart(product2)
user2.addProductToCart(product2)
user2.addProductToCart(product3)

print("\(user1.username)'s Cart Total Price: $\(user1.cart.countPrice())")
print("\(user2.username)'s Cart Total Price: $\(user2.cart.countPrice())")

let totalPricePaidByUser1 = user1.checkout()
let totalPricePaidByUser2 = user2.checkout()

print("\(user1.username) paid: $\(totalPricePaidByUser1)")
print("\(user2.username) paid: $\(totalPricePaidByUser2)")
