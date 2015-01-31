---
title: "Rust DRAFT"
layout: post
---

## Rust ##

http://doc.rust-lang.org/std/marker/trait.Copy.html
closures wo curly brackets

Rustaceans
Rust stickers

PP>
How Programmers fan boys see each other?
http://www.google.lv/imgres?imgurl=http://www.csee.umbc.edu/courses/331/fall10/images/languageFans.jpg&imgrefurl=http://www.csee.umbc.edu/courses/331/fall10/schedule.html&h=405&w=604&tbnid=x8_9ZlrxsELRGM:&zoom=1&docid=EQgvfOk5KfP_vM&ei=4x7IVK_DLauAywO94IL4BA&tbm=isch&ved=0CCMQMygAMAA

PP>
What for:
- c/c++ replacement
- why c?
- what to expect from new language? Why users will jump in?
- what to expect from c replacement?
- OOP is dead

PP>
Lang-Drivers:
- Innovation
- Expressive
- Embedded-able, low-level, safe/secure, predictable

PP>
Historically (mainstream):
- Unix, time-shared OS: ASM, C
- Desktop as commodity, application etc: C/C++,Java
- Web: PHP, Python, Java, .Net
- Smartphone: Java, Object-C, Swift
- Mobile (battery), IoT, etc: Go, Rust (?)

PP>
Rust progress as language
http://en.wikipedia.org/wiki/Rust_%28programming_language%29#History
Ability to take a distant view and step backwards

PP>
LLVM
Grammar
..?

PP>
http://crossthebreeze.files.wordpress.com/2007/08/feature.jpg
Features from the lang site:
Featuring
    zero-cost abstractions
    move semantics
    guaranteed memory safety
    threads without data races
    trait-based generics
    pattern matching
    type inference
    minimal runtime
    efficient C bindings

PP> Concepts
Literals, Variables, Grammar
builtin types
  Primitives
  Tuples
  Strings
  Arrays & Slices & Vectors
    ["hip","hip"]
    (hip hip array!)
  Iterators / Collections (goes here?)
    Design of next() -> Some/None (Option)
  Structures
  Enums / * namespaces * C-like * Pattern matching * Error handling (e.g. Result<T,E> enum) ...
Types (decl, cast, inference)
Aliases http://rustbyexample.com/type/alias.html
Expressions
Flow control:
 if/else
 loops (loop, while, goto, break/continue)
 for (ranges)
Functions
Attributes
Modules
Crates 

PP>
Encapsulation, Inheritance, Polymorphism 
Intro:
 "
 Q: "Whats the object-oriented way to become wealthy?"
 A: Inheritance
 "
OOP? 
Gang of forth https://joshldavis.com/2013/06/16/the-rise-of-the-gang-of-four-with-rust/
Classless OOP https://lwn.net/Articles/548560/
  "
  The many faces of inheritance
  While inheritance is a core concept in object-oriented programming, it is not necessarily a well-defined concept. It always involves one thing getting some features by association with some previously defined things, but beyond that languages differ. The thing is typically a "class", but sometimes an "interface" or even (in prototype inheritance) an "object" that borrows some behavior and state from some other "prototypical" object.
  "
http://en.wikipedia.org/wiki/Type_class and http://en.wikipedia.org/wiki/Ad_hoc_polymorphism
Type system
Trait inheritance
Traits ..(logicall hoop? ..)
C++ Dimanond problem?
trait impl for ...
* type
* generics
* constraints 

PP>
Generics:
Type Bounds
Where clauses

PP>
Pattern matching is the one thing to expect from new/modern programming language

PP> Ownership and moves / borowwing (lending), lifetimes
Safety, no dangling pointers, no nulls, 

    PP>
    > move semantics
    > guaranteed memory safety
     Why it's important - http://en.wikipedia.org/wiki/Tony_Hoare#Apologies_and_retractions
     Billion worth mistake
       
    PP> RAII 
    http://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization
    Quote (applicable?) to lifetime and resource management
    “I brought you into this world,” my father would say, “and I can take you out. It don’t make no difference to me. I’ll just make another one like you.”
    — Bill Cosby, Fatherhood

    PP> Globals / constants / Static lifetime

    PP> Pointer cheatsheet 
        http://doc.rust-lang.org/1.0.0-alpha/book/pointers.html#cheat-sheet
        
        Lifetime elision
        http://doc.rust-lang.org/1.0.0-alpha/book/ownership.html#lifetime-elision
        fn get_str() -> &str;                                   // ILLEGAL, no inputs
        fn frob(s: &str, t: &str) -> &str;                      // ILLEGAL, two inputs

    PP> Samples on borrowing  / lifetime
    PP> Samples on compiler messages
    PP> Unsafe
PP> Closures, Higher Order Functions (HOF), Threads, Channels

PP> IO, file, path examples

PP> Macroses, Lng extensibility, plug-ins etc ...
e.g. chack todo/ warn/xxx in the comments

PP> C / FFI 

PP>
Cargo
- std tool chain
- tests and profiler benchmarks (micro benchmarks)
- rust doc && rust doc tests


PP> 
Safety, Quality, Quantity. In that order.
http://fsharpforfunandprofit.com/assets/img/safety_first.jpg

PP> Haters gonna hate 
http://media.giphy.com/media/A6H1A9rhetsXK/giphy.gif

## Project Ideas ##

- git wiki (git as backend)
- rust book - playpen integration
- rust-book - next - prev
- fmt formatter lint/-er
- todo checker (gh issues)
