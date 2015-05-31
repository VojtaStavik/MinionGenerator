# MinionGenerator

```MinionGenerator``` is a ```struct``` with a few static functions:

	// returns one Minion
    static func randomMinion() -> Minion 

	// returns array of random Minions
    static func minions(count: Int) -> [Minion]



```Minion``` is a class looking like this:

	class Minion: Equatable {
	
	   let name: String
	   let profilePicture: UIImage
	   let profilePictureURL: NSURL
	}



### Example

Add this repository as a Git submodule to your project and import ```MinionGenerator.swift``` and ```Minions.xcassets``` files to your project. **Don't copy it.**

Usage:

	let minion = MinionGenerator.randomMinion()
	let arrayOfMinions = MinionGenerator.minions(15)
	
	
### Other assets


If you don’t need Minions, but some other random Minion-related data, you can use the following functions (their names are self-explanatory):

    static func randomSentence() -> String
    static func randomParagraph(sentences: Int) -> String     
    
    static func randomPicture() -> UIImage 
    static func randomPictures(count: Int) -> [UIImage]

    static func randomPrictureURL() -> NSURL 
    static func randomPictureURLs(count: Int) -> [NSURL] 