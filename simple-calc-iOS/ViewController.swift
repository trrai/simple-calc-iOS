//
//  ViewController.swift
//  simple-calc-iOS
//
//  Created by Tejveer Rai on 10/17/18.
//  Copyright © 2018 Tejveer Rai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var displayValue : Double = 0;
    var currentValue : Double = 0;
    var nums = [Double]()
    var inOperation = false;
    var currentOp = "";
    
    @IBAction func num(_ sender: UIButton) {
        if(inOperation){
            display.text = sender.titleLabel!.text!;
            displayValue = Double(display.text!)!
            inOperation = false;
        }else{
            display.text = display.text! + sender.titleLabel!.text!;
            displayValue = Double(display.text!)!
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        display.text = "";
        displayValue = 0;
        nums = [Double]();
        currentValue = 0;
        currentOp = "";
    }
    
    func calculate(){
        switch(currentOp){
        case "+":
            currentValue = add();
        case "-":
            currentValue = subtract();
        case "x":
            currentValue = multiply();
        case "/":
            currentValue = divide();
        case "%":
            currentValue = mod();
        case "Count":
            currentValue = count();
        case "Avg":
            currentValue = avg();
        case "Fact":
            currentValue = fact();
        default:
            return
        }
    }
    
    @IBAction func operation(_ sender: UIButton) {
        let operationType = sender.titleLabel!.text!;
        switch(operationType){
        case "=":
            //print("current value after equals: \(currentValue)" );
            //print("nums: \(nums)");
            if(currentOp != ""){
                nums.append(displayValue);
                calculate();
            }
            displayValue = currentValue;
            display.text = String(currentValue).replacingOccurrences(of: ".0", with: "");
            nums = [Double]();
            currentOp = "";
            
            //print("current value after equals: \(currentValue)" );
            //print("nums: \(nums)");
        case "+", "-", "x", "/", "%":
            //print("current value before: \(currentValue)");
            //print("nums: \(nums)");
            currentOp = operationType;
            display.text = operationType;
            nums.append(displayValue);
            calculate();
            //print("current value afterwards: \(currentValue)");
            //print("nums: \(nums)");
        case "Count", "Avg", "Fact":
            currentOp = operationType;
            display.text = operationType;
            nums.append(displayValue);
        default:
            return
        }
        inOperation = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func add() -> Double{
        
        var sum : Double = 0
        for num in nums{
            sum += num
        }
        return sum
       
    }
    
    func subtract() -> Double{
        var sum : Double = nums[0]
        if(nums.count > 1){
            for i in 1...nums.count-1{
                sum -= nums[i]
            }
        }
        return sum
    }
    
    func multiply() -> Double{
        var sum : Double = 1
        for num in nums{
            sum *= num
        }
        return sum
    }
    
    func divide() -> Double{
        var sum : Double = nums[0]
        if(nums.count > 1){
            for i in 1...nums.count-1{
                sum /= nums[i]
            }
        }
        return sum
    }
    
    func mod() -> Double{
        var sum : Double = nums[0]
        if(nums.count > 1){
            for i in 1...nums.count-1{
                sum = sum.truncatingRemainder(dividingBy: nums[i])
            }
        }
        return sum
    }
    func count() -> Double{
        return Double(nums.count);
    }
    
    func fact() -> Double{
        print(nums)
        
        if(nums[0] < 0){
            return -1
        }else{
            var fact : Double = 1;
            for i in 1...(Int(nums.first!)){
                fact *= Double(i);
            }
            return fact;
        }
    }
    
    func avg() -> Double{
        return add()/count()
    }
}

