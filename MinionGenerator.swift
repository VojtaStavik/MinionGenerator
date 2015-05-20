//
//  MinionGenerator.swift
//
//  Created by Vojta Stavik on 20/05/15.
//  Copyright (c) 2015 STRV. All rights reserved.
//

import UIKit
import Foundation

struct MinionGenerator: GeneratorType {
    
    typealias Element = Minion
    
    class Minion: Equatable {

        let name: String
        let profilePicture: UIImage
        let profilePictureURL: NSURL
        
        
        init?(name: String) {
            
            self.name = name

            let filePath = __FILE__
            
            let currentDirectoryPath = filePath.substringToIndex(advance(filePath.endIndex, -count("MinionGenerator.swift")))
            
            if let
                
                profilePictureData = NSData(contentsOfFile: currentDirectoryPath + "images/" + name + ".jpg"),
                profilePicture = UIImage(data: profilePictureData, scale: UIScreen.mainScreen().scale),
                profilePictureURL = NSURL(string: "https://raw.githubusercontent.com/VojtaStavik/MinionGenerator/master/images/" + name + ".jpg")
            {
                
                self.profilePicture = profilePicture
                self.profilePictureURL = profilePictureURL
            }
            
            else {
                
                profilePicture = UIImage()
                profilePictureURL = NSURL()
                
                return nil
            }
        }
    }
    
    
    
    func next() -> Element? {
        
        return self.dynamicType.randomMinion()
    }
    
    
    static func randomMinion() -> Minion {
        
        return Minion(name: randomMinionName())!
    }
    
    
    static func randomMinionName() -> String {
        
        return knownMinions.randomItem()!
    }
    
    
    static func minions(count: Int) -> [Minion] {
        
        return createSmartArray(count, randomElement: { () -> Minion in
            
            self.randomMinion()
        })
    }
    
    
    static func paragraph(sentences: Int) -> String {
        
        return ". ".join(createSmartArray(sentences, randomElement: { () -> String in
            
            return self.sourceTextArray.randomItem()!
        }))
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
    
}


func ==<T: MinionGenerator.Minion> (lhs:T, rhs:T) -> Bool {
    
    return lhs.name == rhs.name
}

extension Array {
    
    func randomItem() -> T? {
        
        if self.count == 0 {
            
            return nil
        }
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}