//
//  MinionGenerator.swift
//
//  Created by Vojta Stavik on 20/05/15.
//  Copyright (c) 2015 STRV. All rights reserved.
//

import UIKit
import Foundation

struct MinionGenerator: GeneratorType {
    
    class Minion: Equatable {

        let name: String
        let profilePicture: UIImage
        let profilePictureURL: NSURL
        
        
        init?(name: String) {
            
            self.name = name
            self.profilePictureURL = MinionGenerator.urlForPicture(name)
            
            if let
                
                profilePictureData = NSData(contentsOfFile: MinionGenerator.pathForLocalPicture(name)),
                profilePicture = UIImage(data: profilePictureData, scale: UIScreen.mainScreen().scale)
            {
                
                self.profilePicture = profilePicture
            }
            
            else {
                
                profilePicture = UIImage()
                
                return nil
            }
        }
    }
    
    
    // GeneratorType protocol
    
    typealias Element = Minion
    
    func next() -> Element? {
        
        return self.dynamicType.randomMinion()
    }
    
    
    
    // Random minions
    
    static func randomMinion() -> Minion {
        
        return Minion(name: randomMinionName())!
    }
    
    
    static func randomMinionName() -> String {
        
        return knownMinions.randomItem()
    }
    
    
    static func minions(count: Int) -> [Minion] {
        
        return createSmartArray(count, randomElement: { () -> Minion in
            
            self.randomMinion()
        })
    }
    
    
    
    // Other assets
    
    static func randomSentence() -> String {
        
        return randomParagraph(1)
    }
    
    
    static func randomParagraph(sentences: Int) -> String {
        
        return ". ".join(createSmartArray(sentences, randomElement: { () -> String in
            
            return self.sourceTextArray.randomItem()
        }))
    }
    
    
    static func randomPicture() -> UIImage {
        
        return UIImage(data: NSData(contentsOfFile: pathForLocalPicture(randomImageNames.randomItem()))!, scale: UIScreen.mainScreen().scale)!
    }
    
    
    static func randomPrictureURL() -> NSURL {
        
        return urlForPicture(randomImageNames.randomItem())
    }
    
    
    static func randomPictures(count: Int) -> [UIImage] {
        
        return createSmartArray(count, randomElement: { () -> UIImage in
            
            self.randomPicture()
        })
    }

    
    static func randomPictureURLs(count: Int) -> [NSURL] {
        
        return createSmartArray(count, randomElement: { () -> NSURL in
            
            self.randomPrictureURL()
        })
    }

    
    // MARK: - Private functions
    
    private static func pathForLocalPicture(name: String) -> String {
        
        let filePath = __FILE__
        let currentDirectoryPath = filePath.substringToIndex(advance(filePath.endIndex, -count("MinionGenerator.swift")))

        return currentDirectoryPath + "images/" + name + ".jpg"
    }

    
    private static func urlForPicture(name: String) -> NSURL {
        
        return NSURL(string: ("https://raw.githubusercontent.com/VojtaStavik/MinionGenerator/master/images/" + name + ".jpg").lowercaseString)!
    }
    
    
    
    // Returns an array of elements where two similar elements are not next to each other
    private static func createSmartArray<T: Equatable>(numberOfElements: Int, randomElement: () -> T) -> [T] {
        
        var array = [T]()
        
        if numberOfElements > 0 {
            
            array.append(randomElement())
        }
        
        else {
            
            return array
        }
        
        
        do {
        
            let newElement = randomElement()
            
            if let lastElement = array.last where lastElement != newElement {
            
                array.append(newElement)
            }
        
        } while (array.count < numberOfElements)
        
        
        return array
    }
    
    
    // MARK: - Data sources
    
    static private let knownMinions = [

        "Dave",
        "Stuart",
        "Bob",
        "Kevin",
        "Carl",
        "Jerry",
        "Steve",
        "Mike",
        "Phil",
        "Tim",
        "Paul",
        "Norbert"
    ]
    
    static private let sourceTextArray = "Evolving from single-celled yellow organisms at the dawn of time, Minions live to serve, but find themselves working for a continual series of unsuccessful masters, from T. Rex to Napoleon. Without a master to grovel for, the Minions fall into a deep depression. But one minion, Kevin, has a plan; accompanied by his pals Stuart and Bob, Kevin sets forth to find a new evil boss for his brethren to follow. Their search leads them to Scarlet Overkill, the world's first-ever super-villainess. A man who delights in all things wicked, supervillain Gru hatches a plan to steal the moon. Surrounded by an army of little yellow minions and his impenetrable arsenal of weapons and war machines, Gru makes ready to vanquish all who stand in his way. But nothing in his calculations and groundwork has prepared him for his greatest challenge: three adorable orphan girls who want to make him their dad. Now that Gru has forsaken a life of crime to raise Margo, Agnes and Edith, he's trying to figure out how to provide for his new family. As he struggles with his responsibilities as a father, the Anti-Villain League -- an organization dedicated to fighting evil -- comes calling. The AVL sends Gru on a mission to capture the perpetrator of a spectacular heist, for who would be better than the world's greatest ex-villain to capture the individual who seeks to usurp his power".componentsSeparatedByString(". ")
    
    static private let randomImageNames = [
    
        "random1",
        "random2",
        "random3",
        "random4",
        "random5"
    ]
    
}


func ==<T: MinionGenerator.Minion> (lhs:T, rhs:T) -> Bool {
    
    return lhs.name == rhs.name
}

extension Array {
    
    func randomItem() -> T {
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}