//
//  TrieTests.swift
//  GiveMeAnOfferTests
//
//  Created by 姜振华 on 2019/7/28.
//

import XCTest
@testable import GiveMeAnOffer

class TrieTests: XCTestCase {

    var wordArray: [String]?
    var trie = Trie()
    
    /// Makes sure that the wordArray and trie are initialized before each test.
    override func setUp() {
        super.setUp()
        createWordArray()
        insertWordsIntoTrie()
    }
    
    /// Don't need to do anything here because the wordArray and trie should
    /// stay around.
    override func tearDown() {
        super.tearDown()
    }
    
    /// Reads words from the dictionary file and inserts them into an array.  If
    /// the word array already has words, do nothing.  This allows running all
    /// tests without repeatedly filling the array with the same values.
    func createWordArray() {
        guard wordArray == nil else {
            return
        }
      
        var data: String?
        do {
            data = try String(contentsOf: URL(string: "https://raw.githubusercontent.com/raywenderlich/swift-algorithm-club/master/Trie/Trie/Trie/dictionary.txt")!, encoding: .utf8)
        } catch  {
            XCTAssertNil(error)
        }
        XCTAssertNotNil(data)
        let dictionarySize = 162825
        wordArray = data!.components(separatedBy: "\n")
        XCTAssertEqual(wordArray!.count, dictionarySize)
    }
    
    /// Inserts words into a trie.  If the trie is non-empty, don't do anything.
    func insertWordsIntoTrie() {
        guard let wordArray = wordArray, trie.count == 0 else { return }
        for word in wordArray {
            trie.insert(word: word)
        }
    }
    
    /// Tests that a newly created trie has zero words.
    func testCreate() {
        let trie = Trie()
        XCTAssertEqual(trie.count, 0)
    }
    
    /// Tests the insert method
    func testInsert() {
        let trie = Trie()
        trie.insert(word: "cute")
        trie.insert(word: "cutie")
        trie.insert(word: "fred")
        XCTAssertTrue(trie.contains(word: "cute"))
        XCTAssertFalse(trie.contains(word: "cut"))
        trie.insert(word: "cut")
        XCTAssertTrue(trie.contains(word: "cut"))
        XCTAssertEqual(trie.count, 4)
    }
    
    /// Tests the remove method
    func testRemove() {
        let trie = Trie()
        trie.insert(word: "cute")
        trie.insert(word: "cut")
        XCTAssertEqual(trie.count, 2)
        trie.remove(word: "cute")
        XCTAssertTrue(trie.contains(word: "cut"))
        XCTAssertFalse(trie.contains(word: "cute"))
        XCTAssertEqual(trie.count, 1)
    }
    
    /// Tests the words property
    func testWords() {
        let trie = Trie()
        var words = trie.words
        XCTAssertEqual(words.count, 0)
        trie.insert(word: "foobar")
        words = trie.words
        XCTAssertEqual(words[0], "foobar")
        XCTAssertEqual(words.count, 1)
    }
    
    /// Tests the performance of the insert method.
    func testInsertPerformance() {
        self.measure {
            let trie = Trie()
            for word in self.wordArray! {
                trie.insert(word: word)
            }
        }
        XCTAssertGreaterThan(trie.count, 0)
        XCTAssertEqual(trie.count, wordArray?.count)
    }
    
    /// Tests the performance of the insert method when the words are already
    /// present.
    func testInsertAgainPerformance() {
        self.measure {
            for word in self.wordArray! {
                self.trie.insert(word: word)
            }
        }
    }
    
    /// Tests the performance of the contains method.
    func testContainsPerformance() {
        self.measure {
            for word in self.wordArray! {
                XCTAssertTrue(self.trie.contains(word: word))
            }
        }
    }
    
    /// Tests the performance of the remove method.  Since setup has already put
    /// words into the trie, remove them before measuring performance.
    func testRemovePerformance() {
        for word in self.wordArray! {
            self.trie.remove(word: word)
        }
        self.measure {
            self.insertWordsIntoTrie()
            for word in self.wordArray! {
                self.trie.remove(word: word)
            }
        }
        XCTAssertEqual(trie.count, 0)
    }
    
    /// Tests the performance of the words computed property.  Also tests to see
    /// if it worked properly.
    func testWordsPerformance() {
        var words: [String]?
        self.measure {
            words = self.trie.words
        }
        XCTAssertEqual(words?.count, trie.count)
        for word in words! {
            XCTAssertTrue(self.trie.contains(word: word))
        }
    }
    
    /// Tests the archiving and unarchiving of the trie.
    func testArchiveAndUnarchive() {
        let resourcePath = NSTemporaryDirectory() as NSString
        let fileName = "dictionary-archive"
        let filePath = resourcePath.appendingPathComponent(fileName)
        NSKeyedArchiver.archiveRootObject(trie, toFile: filePath)
        let trieCopy = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? Trie
        XCTAssertEqual(trieCopy?.count, trie.count)
    }
    
    func testFindWordsWithPrefix() {
        let trie = Trie()
        trie.insert(word: "test")
        trie.insert(word: "another")
        trie.insert(word: "exam")
        let wordsAll = trie.findWordsWithPrefix(prefix: "")
        XCTAssertEqual(wordsAll.sorted(), ["another", "exam", "test"])
        let words = trie.findWordsWithPrefix(prefix: "ex")
        XCTAssertEqual(words, ["exam"])
        trie.insert(word: "examination")
        let words2 = trie.findWordsWithPrefix(prefix: "exam")
        XCTAssertEqual(words2, ["exam", "examination"])
        let noWords = trie.findWordsWithPrefix(prefix: "tee")
        XCTAssertEqual(noWords, [])
        let unicodeWord = "😬😎"
        trie.insert(word: unicodeWord)
        let wordsUnicode = trie.findWordsWithPrefix(prefix: "😬")
        XCTAssertEqual(wordsUnicode, [unicodeWord])
        trie.insert(word: "Team")
        let wordsUpperCase = trie.findWordsWithPrefix(prefix: "Te")
        XCTAssertEqual(wordsUpperCase.sorted(), ["team", "test"])
    }

    static var allTests = [
        ("创建", testCreate),
        ("插入", testInsert),
        ("移除", testRemove),
        ("words属性", testWords),
        ("插入性能", testInsertPerformance),
        ("查找性能", testContainsPerformance),
        ("计算属性Words性能", testWordsPerformance),
        ("移除性能", testRemovePerformance),
        ("归档解档", testArchiveAndUnarchive),
        ("前缀查找", testFindWordsWithPrefix)
    ]
}
