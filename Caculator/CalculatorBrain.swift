//
//  CalculatorBrain.swift
//  Caculator
//
//  Created by Rui Wang on 18/1/27.
//  Copyright © 2018年 Rui Wang. All rights reserved.
//

import Foundation


func changeSign(operand: Double) -> Double {
    return -operand
}

func multiply(lh: Double, rh: Double) -> Double {
    return lh * rh
}

struct CalculatorBrain{
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations: Dictionary<String, Operation> =
    [
        "π" : Operation.constant(M_PI),
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation({ -$0}),
        "x": Operation.binaryOperation({ $0 * $1 }),
        "÷": Operation.binaryOperation({ $0 / $1}),
        "+": Operation.binaryOperation({ $0 + $1}),
        "-": Operation.binaryOperation({ $0 - $1} ),
        "=": Operation.equals
        
    ]
    
    mutating func performOperation(symbol: String) {
        
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            
            
            case .binaryOperation(let function):
                if accumulator != nil {
                      pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            
            case .equals:
                performPendingBinaryOperation()
                
            }
        }
        
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(operand: Double) {
        accumulator = operand
        
    }
    
    var result: Double? {
        get {
            return accumulator
            
        }
    }
    
    
}