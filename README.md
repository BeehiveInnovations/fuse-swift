## What is Fuse?

Fuse is a super lightweight library which provides a simple way to do fuzzy searching.

![Demo](https://i.postimg.cc/MZNZPD1F/bitap-search-demo.gif)

## Usage

#### Example 1

```swift
let fuse = Fuse()
let result = fuse.search("od mn war", in: "Old Man's War")

print(result?.score)  // 0.44444444444444442
print(result?.ranges) // [CountableClosedRange(0...0), CountableClosedRange(2...6), CountableClosedRange(9...12)]
```

#### Example 2

Search for a text pattern in an array of srings.

```swift
let books = ["The Silmarillion", "The Lock Artist", "The Lost Symbol"]
let fuse = Fuse()

// Improve performance by creating the pattern once
let pattern = fuse.createPattern(from: "Te silm")

// Search for the pattern in every book
books.forEach {
    let result = fuse.search(pattern, in: $0)
    print(result?.score)
    print(result?.ranges)
}
```

#### Example 3

```swift
class Book: Fuseable {
    dynamic var name: String
    dynamic var author: String

    var properties: [FuseProperty] {
        return [
            FuseProperty(value: title, weight: 0.3),
            FuseProperty(value: author, weight: 0.7)
        ]
    }
}

let books: [Book] = [
    Book(title: "Old Man's War fiction", author: "John X"),
    Book(title: "Right Ho Jeeves", author: "P.D. Mans")
]

let fuse = Fuse()
let results = fuse.search("man", in: books)

results.forEach { item in
    print("index: " + item.index)
    print("score: " + item.score)
    print("results: " + item.results)
    print("---------------")
}

// Output:
//
// index: 1
// score: 0.015000000000000003
// results: [(value: "P.D. Mans", score: 0.015000000000000003, ranges: [CountableClosedRange(5...7)])]
// ---------------
// index: 0
// score: 0.027999999999999997
// results: [(value: "Old Man\'s War fiction", score: 0.027999999999999997, ranges: [CountableClosedRange(4...6)])]
```

#### Example 4

```swift
let fuse = Fuse()
fuse.search("Man", in: books, completion: { results in
    print(results)
})
```

### Options

`Fuse` takes the following options:

- `location`: Approximately where in the text is the pattern expected to be found. Defaults to `0`
- `distance`: Determines how close the match must be to the fuzzy `location` (specified above). An exact letter match which is `distance` characters away from the fuzzy location would score as a complete mismatch. A distance of `0` requires the match be at the exact `location` specified, a `distance` of `1000` would require a perfect match to be within `800` characters of the fuzzy location to be found using a 0.8 threshold. Defaults to `100`
- `threshold`: At what point does the match algorithm give up. A threshold of `0.0` requires a perfect match (of both letters and location), a threshold of `1.0` would match anything. Defaults to `0.6`
- `maxPatternLength`: The maximum valid pattern length. The longer the pattern, the more intensive the search operation will be. If the pattern exceeds the `maxPatternLength`, the `search` operation will return `nil`. Why is this important? [Read this](https://en.wikipedia.org/wiki/Word_(computer_architecture)#Word_size_choice). Defaults to `32`
- `isCaseSensitive`: Indicates whether comparisons should be case sensitive. Defaults to `false`

## Installation

Fuse is available through [Swift Package Manager](https://swift.org/package-manager/). To add the package to your Xcode project, simply go to "File" -> "Swift Packages" -> "Add Package Dependency..." and paste the repo URL.

## License

Fuse is available under the MIT license. See the LICENSE file for more info.
