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



### How to use it

The preferable way how to install MinionGenerator is by using [Carthage](https://github.com/Carthage/Carthage). Add this line to your ```Cartfile```

    github "VojtaStavik/MinionGenerator"
    


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