//
//  InterfaceController.swift
//  iBox Watch Extension
//
//  Created by ALEKSANDER ONISZCZAK on 2019-10-22.
//  Copyright © 2019 MocaMatrol. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var pickLable: WKInterfaceLabel!
    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var guessButton: WKInterfaceButton!
    
    var number = Int.random(in: 1 ..< 10)
    var guessedNumber: Int = 0
    var newGame = false
    
    var itemList: [(String, String)] = [
    ("Item 1", "1"),
    ("Item 2", "2"),
    ("Item 3", "3"),
    ("Item 4", "4"),
    ("Item 5", "5"),
    ("Item 6", "6"),
    ("Item 7", "7"),
    ("Item 8", "8"),
    ("Item 9", "9"),
    ("Item 10", "10") ]
    
    //var itemList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let pickerItems: [WKPickerItem] = itemList.map {
            let pickerItem = WKPickerItem()
            pickerItem.caption = $0.0
            pickerItem.title = $0.1
            return pickerItem
        }
        picker.setItems(pickerItems)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        picker.focus()
        print ("The secret number is \(number)")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func guessButtonTapped() {
        
        if newGame == true {
            newGame = false
            self.pickLable.setText("Pick 1 - 10")
            guessButton.setTitle("GUESS")
            WKInterfaceDevice.current().play(.start)
        }
        else {
            pickLable.setText("Thinking.")
            WKInterfaceDevice.current().play(.click)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.pickLable.setText("Thinking..")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.pickLable.setText("Thinking...")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                        //print (pickerItem.title)
                        if self.number == self.guessedNumber {
                            self.pickLable.setText("Correct!")
                            WKInterfaceDevice.current().play(.success)
                            self.guessButton.setTitle("NEW GAME")
                            self.number = Int.random(in: 1 ..< 10)
                            print ("The new secret number is \(self.number)")
                            self.newGame = true
                        }
                        else if self.number < self.guessedNumber {
                            self.pickLable.setText("Lower!")
                            WKInterfaceDevice.current().play(.directionDown)
                        }
                        else if self.number > self.guessedNumber {
                            self.pickLable.setText("Higher!")
                            WKInterfaceDevice.current().play(.directionUp)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func pickerChanged(_ value: Int) {
        WKInterfaceDevice.current().play(.click)
        guessButton.setTitle("GUESS " + itemList[value].1)
        guessedNumber = Int(itemList[value].1)!
    }
    
}
