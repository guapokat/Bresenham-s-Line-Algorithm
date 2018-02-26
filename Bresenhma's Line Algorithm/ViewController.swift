//
//  ViewController.swift
//  Bresenhma's Line Algorithm
//
//  Created by Virgil Martinez on 2/25/18.
//  Copyright © 2018 Virgil Alexander Martinez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var appTitle: UILabel!
    //point output
    @IBOutlet weak var pointOutput: UITextView!
    
    //point(s) input
        //TOP
    @IBOutlet weak var topLeftInputValue: UITextField!
    @IBOutlet weak var topRightInputValue: UITextField!
        //BOTTOM
    @IBOutlet weak var botLeftInputValue: UITextField!
    @IBOutlet weak var botRightInputValue: UITextField!
    
    //MARK: - ACTIONS
    @IBAction func calculateBtnPressed(_ sender: UIButton) {
        let notEmpty = checkInputs()
        if !notEmpty {
            //presenting alert that one of the inputs is empty
            let alert = UIAlertController(title: "Alert", message: "One or more points missing", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else {
            //casting inputs to variables (they are optional values so ! explicitly unrwaps because the if above checks they are present)
            let x1 = Int(botLeftInputValue.text!)
            let y1 = Int(botRightInputValue.text!)
            let x2 = Int(topLeftInputValue.text!)
            let y2 = Int(topRightInputValue.text!)
            
            bresenhamsAlg(x1: x1!, y1: y1!, x2: x2!, y2: y2!)
        }
    }
    
    //MARK: - SYSTEM FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //Dismissing keyboard on tap out of
        hideKeyboardWhenTappedAround()
        
        //Setting title background to rounded corner
        appTitle.layer.masksToBounds = true
        appTitle.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Personal Functions
    func checkInputs() -> Bool{
        var allIn = false
        if !topLeftInputValue.text!.isEmpty && !topRightInputValue.text!.isEmpty && !botLeftInputValue.text!.isEmpty && !botRightInputValue.text!.isEmpty {
            allIn = true
            return allIn
        }
        return allIn
    }
    func bresenhamsAlg(x1: Int, y1: Int, x2: Int, y2: Int) {
        //init
        var x1 = x1
        var x2 = x2
        var y1 = y1
        var y2 = y2
        //deltas
        let deltaX = x2 - x1
        let deltaY = y2 - y1
        //swapping
        let steepSlope = abs(deltaY) > abs(deltaX)
        if steepSlope {
            x1 = y1
            y1 = x1
            x2 = y2
            y2 = x2
        }
        if x2 < x1 {
            let tmpX = x1
            let tmpY = y1
            x1 = x2
            y1 = y2
            x2 = tmpX
            y2 = tmpY
        }
        //outcomes
        var xPoints = [Int]()
        var yPoints = [Int]()
        
        //calculations
        let incY = (deltaY >= 0) ? 1 : -1
        let slope = abs(Float(deltaY) / Float(deltaX))
        var error: Float = 0
        let x = x1
        var y = y1
        
        for i in (x + 1)...x2 {
            error += slope
            if (error >= 0.5) {
                y += incY
                error -= 1
            }
            xPoints.append(i)
            yPoints.append(y)
            //print("\(i),\(y)")
        }
        printOutput(xData: xPoints, yData: yPoints)
    }
    func printOutput(xData: [Int], yData: [Int]) {
        var outString = ""
        for i in 0..<xData.count {
            if i == xData.count - 1 {
                outString.append("(\(xData[i]),\(yData[i]))")
            }else {
                outString.append("(\(xData[i]),\(yData[i])); ")
            }
        }
        print(outString)
        pointOutput.text = outString
    }

}

