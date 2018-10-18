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
    var displayValue : Int = 0;
    var currentValue = 0;
    var nums = [Int]()
    var inOperation = false;
    var currentOp = "";
    
    @IBAction func num(_ sender: UIButton) {
        if(inOperation){
            display.text = sender.titleLabel!.text!;
            displayValue = Int(display.text!)!
            inOperation = false;
        }else{
            display.text = display.text! + sender.titleLabel!.text!;
            displayValue = Int(display.text!)!
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        display.text = "";
        displayValue = 0;
        nums = [Int]();
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
            display.text = String(currentValue);
            nums = [Int]();
            currentOp = "";
            
            print("current value after equals: \(currentValue)" );
            print("nums: \(nums)");
        case "+", "-", "x", "/", "%":
            print("current value before: \(currentValue)");
            print("nums: \(nums)");
            currentOp = operationType;
            display.text = operationType;
            nums.append(displayValue);
            calculate();
            print("current value afterwards: \(currentValue)");
            print("nums: \(nums)");
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
    
    func add() -> Int{
        
        var sum = 0
        for num in nums{
            sum += num
        }
        return sum
       
    }
    
    func subtract() -> Int{
        var sum = nums[0]
        if(nums.count > 1){
            for i in 1...nums.count-1{
                sum -= nums[i]
            }
        }
        return sum
    }
    
    func multiply() -> Int{
        var sum = 1
        for num in nums{
            sum *= num
        }
        return sum
    }
    
    func divide() -> Int{
        var sum = nums[0]
        if(nums.count > 1){
            for i in 1...nums.count-1{
                sum /= nums[i]
            }
        }
        return sum
    }
    
    func mod() -> Int{
        var sum = nums[0]
        if(nums.count > 1){
            for i in 1...nums.count-1{
                sum %= nums[i]
            }
        }
        return sum
    }
    func count() -> Int{
        return nums.count;
    }
    
    func fact() -> Int{
        print(nums)
        
        if(nums[0] < 0){
            return -1
        }else{
            var fact = 1;
            for i in 1...(nums.first ?? 1){
                fact *= i;
            }
            return fact;
        }
    }
    
    func avg() -> Int{
        return add()/count()
    }
}

