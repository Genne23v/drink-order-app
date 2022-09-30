//
//  ViewController.swift
//  A1Wonkeun
//
//  Created by Wonkeun No on 2022-09-28.
//

import UIKit

class ViewController: UIViewController {

    //MARK: variables
    let BUBBLES = "Bubbles"
    let RED_BEAN = "Red Bean"
    let GRASS_JELLY = "Grass Jelly"
    let MANGO_PUDDING = "Mango Pudding"
    
    let SMALL = "Small"
    let MEDIUM = "Medium"
    let LARGE = "Large"
    
    let SALES_TAX_RATE = 0.13
    
    var numOfDrinks:Int = 1
    var pricePerDrink:Double = 3.5
    var icePrice:Double = 0.0
    var toppingPrice:Double = 0.0
    var drinkSzie:String = "Medium"
    var toppings:String = ""
    var iceAdded:Bool = false
    var discounted:Bool = false
    
    var orderTotal:Double = 0.0
    var discount:Double = 0.0
    var salesTax:Double = 0.0
    var total:Double = 0.0
    
    //MARK: outlets
    @IBOutlet weak var pageHeader: UILabel!
    @IBOutlet weak var orderMsgBox: UILabel!
    
    @IBOutlet weak var lblNumOfDrinks: UILabel!
    @IBOutlet weak var numOfDrinkStepper: UIStepper!
    
    @IBOutlet weak var drinkSizeSegment: UISegmentedControl!
    
    @IBOutlet weak var lblSugarLevel: UILabel!
    @IBOutlet weak var sugarLevelSlider: UISlider!

    @IBOutlet weak var iceSwitch: UISwitch!
    @IBOutlet var toppingSelectionControl: [UISwitch]!
    
    @IBOutlet weak var couponBox: UITextField!
    @IBOutlet weak var errorMsgBox: UILabel!
    
    @IBOutlet weak var orderDetail: UITextView!
    @IBOutlet weak var orderSummary: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numOfDrinkStepper.value = 1
        drinkSizeSegment.selectedSegmentIndex = 1
        updateOrderSummary(orderTotal: 4.5, discount: 0.0, salesTax: 0.59, total: 5.09)
    }

    //MARK: actions
    @IBAction func numOfDrinkControl(_ sender: Any) {
        numOfDrinks = Int(numOfDrinkStepper.value)
        lblNumOfDrinks.text = "Choose quantity          \(Int(numOfDrinkStepper.value))"
        
        calculateOrderSummary()
        updateOrderDetail(quantity: numOfDrinks, size: drinkSzie, ice: iceAdded, topppings: toppings)
        updateOrderSummary(orderTotal: orderTotal, discount: discount, salesTax: salesTax, total: total)
    }
    
    @IBAction func drinkSizeControl(_ sender: Any) {
        switch drinkSizeSegment.selectedSegmentIndex {
        case 0:
            drinkSzie = drinkSizeSegment.titleForSegment(at: 0)!
            pricePerDrink = 3.5 + icePrice + toppingPrice
            break
        case 1:
            drinkSzie = drinkSizeSegment.titleForSegment(at: 1)!
            pricePerDrink = 4.5 + icePrice + toppingPrice
            break
        case 2:
            drinkSzie = drinkSizeSegment.titleForSegment(at: 2)!
            pricePerDrink = 6.5 + icePrice + toppingPrice
            break
        default:
            break
        }
        calculateOrderSummary()
        updateOrderDetail(quantity: numOfDrinks, size: drinkSzie, ice: iceAdded, topppings: toppings)
        updateOrderSummary(orderTotal: orderTotal, discount: discount, salesTax: salesTax, total: total)
    }
    
    @IBAction func iceSwitchControl(_ sender: Any) {
        if (iceSwitch.isOn == true){
            iceAdded = true
            icePrice += 1.0
        } else {
            iceAdded = false
            icePrice -= 1.0
        }
        calculateOrderSummary()
        updateOrderDetail(quantity: numOfDrinks, size: drinkSzie, ice: iceAdded, topppings: toppings)
        updateOrderSummary(orderTotal: orderTotal, discount: discount, salesTax: salesTax, total: total)
    }
    
    
    @IBAction func bubbleSwitchPressed(_ sender: Any) {
        if (toppingSelectionControl[0].isOn == true){
            if (toppings.isEmpty){
                toppings += BUBBLES
            } else {
                toppings += ", " + BUBBLES
            }
            toppingPrice += 0.8
        } else {
            let splitToppings = toppings.components(separatedBy: ", ")
            var temp:[String] = []
            toppings = ""
            for topping in splitToppings {
                if (topping != BUBBLES){
                    temp.append(topping)
                }
            }
            toppings = temp.joined(separator: ", ")
            toppingPrice -= 0.8
        }
        calculateOrderSummary()
        updateOrderDetail(quantity: numOfDrinks, size: drinkSzie, ice: iceAdded, topppings: toppings)
        updateOrderSummary(orderTotal: orderTotal, discount: discount, salesTax: salesTax, total: total)
    }
    
    @IBAction func redBeanSwitchPressed(_ sender: Any) {
        if (toppingSelectionControl[1].isOn == true){
            if (toppings.isEmpty){
                toppings += RED_BEAN
            } else {
                toppings += ", " + RED_BEAN
            }
            toppingPrice += 0.8
        } else {
            let splitToppings = toppings.components(separatedBy: ", ")
            var temp:[String] = []
            toppings = ""
            for topping in splitToppings {
                if (topping != RED_BEAN){
                    temp.append(topping)
                }
            }
            toppings = temp.joined(separator: ", ")
            toppingPrice += 0.8
        }
        calculateOrderSummary()
        updateOrderDetail(quantity: numOfDrinks, size: drinkSzie, ice: iceAdded, topppings: toppings)
        updateOrderSummary(orderTotal: orderTotal, discount: discount, salesTax: salesTax, total: total)
    }
    
    @IBAction func grassJellySwitchPressed(_ sender: Any) {
        if (toppingSelectionControl[2].isOn == true){
            if (toppings.isEmpty){
                toppings += GRASS_JELLY
            } else {
                toppings += ", " + GRASS_JELLY
            }
            toppingPrice += 0.8
        } else {
            let splitToppings = toppings.components(separatedBy: ", ")
            var temp:[String] = []
            toppings = ""
            for topping in splitToppings {
                if (topping != GRASS_JELLY){
                    temp.append(topping)
                }
            }
            toppings = temp.joined(separator: ", ")
            toppingPrice -= 0.8
        }
        calculateOrderSummary()
        updateOrderDetail(quantity: numOfDrinks, size: drinkSzie, ice: iceAdded, topppings: toppings)
        updateOrderSummary(orderTotal: orderTotal, discount: discount, salesTax: salesTax, total: total)
    }
    
    @IBAction func mangoPuddingSwitchPressed(_ sender: Any) {
        if (toppingSelectionControl[3].isOn == true){
            if (toppings.isEmpty){
                toppings += MANGO_PUDDING
            } else {
                toppings += ", " + MANGO_PUDDING
            }
            toppingPrice += 0.8
        } else {
            let splitToppings = toppings.components(separatedBy: ", ")
            var temp:[String] = []
            toppings = ""
            for topping in splitToppings {
                if (topping != MANGO_PUDDING){
                    temp.append(topping)
                }
            }
            toppings = temp.joined(separator: ", ")
            toppingPrice -= 0.8
        }
        calculateOrderSummary()
        updateOrderDetail(quantity: numOfDrinks, size: drinkSzie, ice: iceAdded, topppings: toppings)
        updateOrderSummary(orderTotal: orderTotal, discount: discount, salesTax: salesTax, total: total)
    }
        
    @IBAction func sugarLevelControl(_ sender: Any) {
        print("Current sugar level is \(Int(sugarLevelSlider.value))")
        lblSugarLevel.text = "Sugar Lv \((Int(sugarLevelSlider.value)/25)*25)%"
    }
    
    @IBAction func discountCodeBtn(_ sender: Any) {
        errorMsgBox.text = ""
        if (couponBox.text?.trimmingCharacters(in: .whitespaces).uppercased() == "BBT20"){
            discounted = true
            discount = orderTotal * 0.2
            salesTax = (orderTotal - discount) * SALES_TAX_RATE
            total = orderTotal - discount + salesTax
        } else {
            discounted = false
            discount = 0.0
            salesTax = (orderTotal - discount) * SALES_TAX_RATE
            total = orderTotal - discount + salesTax
            errorMsgBox.text = "Invalid code. Please try another code."
        }
        updateOrderSummary(orderTotal: orderTotal, discount: discount, salesTax: salesTax, total: total)
    }
    

    @IBAction func orderBtnPressed(_ sender: Any) {
        orderMsgBox.text = ""
        if (numOfDrinks == 0){
            orderMsgBox.textColor = UIColor.red
            orderMsgBox.text = "Order must have at least 1 drink"
        } else {
            pageHeader.text = "Thank You For Your Order"
            orderMsgBox.textColor = UIColor.black
            orderMsgBox.text = "Your drink is on the way. See you soon!"
        }
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        numOfDrinks = 1
        numOfDrinkStepper.value = 1
        lblNumOfDrinks.text = "How many?              \(Int(numOfDrinkStepper.value))"
        
        drinkSzie = MEDIUM
        drinkSizeSegment.selectedSegmentIndex = 1
        
        lblSugarLevel.text = "Sugar Lv 50%"
        sugarLevelSlider.value = 50
        
        iceAdded = false
        icePrice = 0.0
        iceSwitch.isOn = false
        
        toppingPrice = 0.0
        toppings = ""
        for each in toppingSelectionControl {
            each.isOn = false
        }
        
        discounted = false
        couponBox.text = ""
        
        orderTotal = 4.5
        discount = 0.0
        salesTax = orderTotal * SALES_TAX_RATE
        total = orderTotal + salesTax
        
        updateOrderDetail(quantity: numOfDrinks, size: drinkSzie, ice: iceAdded, topppings: toppings)
        updateOrderSummary(orderTotal: orderTotal, discount: discount, salesTax: salesTax, total: total)
    }
    
    
    func updateOrderDetail(quantity:Int, size:String, ice:Bool, topppings:String){
        orderDetail.text = ""
        orderDetail.text += "Quantity: \(quantity)\n"
        orderDetail.text += "Size: \(size)\n"
        if (ice){
            orderDetail.text += "Add Ice? Yes\n"
        } else {
            orderDetail.text += "Add Ice? No\n"
        }
        orderDetail.text += "Toppings: " + toppings
    }
    
    func updateOrderSummary(orderTotal:Double, discount:Double, salesTax:Double, total:Double){
        orderSummary.text = ""
        orderSummary.text += "Order Total:\t\t$\(String(format: "%.2f", orderTotal))\n"
        orderSummary.text += "Discount:\t\t-$\(String(format: "%.2f", discount))\n"
        orderSummary.text += "Sales Tax:\t\t$\(String(format: "%.2f", salesTax))\n"
        orderSummary.text += "Total:\t\t\t$\(String(format: "%.2f", total))"
    }
    
    func calculateOrderSummary() {
        orderTotal = (pricePerDrink + icePrice + toppingPrice) * Double(numOfDrinks)
        if (discounted){
            discount = orderTotal * 0.2
        }
        salesTax = (orderTotal - discount) * SALES_TAX_RATE
        total = orderTotal - discount + salesTax
    }
    
    //MARK: End of the file
}

