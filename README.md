# advent-of-code-2018

## Day 1

**Language: Rust**

For Day 1, I randomly decided to implement it in Rust. I have been wanting to try out Rust for a long time and decided to finally bite the bullet.

First impression. Wow, this documentaiton is great! Cargo is great! Everything is built in and decided for you! No one's opinion matters! I'm getting some weird EmberJS nostalgia!

_30 minutes later_

Ok, does this work? Maybe I need to read the docs more...

I found myself struggling with some concepts as it is quite verbose. Types are not as clear as C++ or Java, but there is so many things done well in the ecosystem that I will definitely need to work with this again in the future.

Rating: 4/5

## Day 2

**Language: Go**

For Day 2 I used Go. The first thing I didn't like about Go was the setup. It was strange that I had to set the `$GOPATH` env variable. I decided to keep Day 2 in this repo, so I set it with a shell script instead of keeping all projects in the same dir. If there's another way of doing this, it was not mentioned on the golang website.

Besides that, I found the syntax easy to read/understand. Even though my project was small and probably not a good judge, dev iterations were quick which is always a plus. There was a decent amount of convenience methods and the types were consistent with other languages. I also really like the `go fmt` tool.

Also my algorithm was terrible for Part 2. Don't hate me.

Rating: 3/5

## Day 3

**Language: Kotlin**

Kotlin was my language of choice for Day 3. It was surprisingly quick to get going with Kotlin. Installing the tools were easy and didn't require the use of IntelliJ or anything like that. I used `kotlinc` to compile inline and then run the jar file with `java -jar`.

The compiler errors were very understandable. If something was wrong at build time in my code, the error was good enough for me to fix it quickly. This helped improved my development speed while using Kotlin, as I didn't have to look any errors up.

One thing I really liked about Kotlin was its native immutability with `var` vs `val`. The `val` keyword was idential to the same keyword in Scala. It was also very easy to unpack optional or potentially null values with either the `!!` or `?` operators.

The types were also very readable. They were similar to types defined in TypeScript. This was a nice convenience as I write a lot of TypeScript for my day job.

I didn't look into any of the cross compilation features of Kotlin, but it's pretty cool I can use this language to write web apps or Android apps. The ability to write cross platform applications with a tool built-in to the language instead of using a 3rd party library of components is huge. I will definitely consider using Kotlin for writing apps in the future.

Rating: 5/5
