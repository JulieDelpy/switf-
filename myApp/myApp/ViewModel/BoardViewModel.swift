//
//  BoardModel.swift
//  myApp
//
//  Created by 陈慧琦 on 2023/3/28.
//

import Foundation
import SwiftUI

//
//得到棋盘起始x坐标
public func originX(bounds:CGRect) -> CGFloat {
    let cols:Int = 15
    return (bounds.size.width - CGFloat(cols - 1) * cellSide(bounds: bounds)) / 2
}

//得到棋盘起始y坐标
public func originY(bounds:CGRect) -> CGFloat {
    let rows:Int = 15
    return (bounds.size.height - CGFloat(rows - 1) * cellSide(bounds: bounds)) / 2
}

//得到一个格子的尺寸
public func cellSide(bounds:CGRect) -> CGFloat {
    let rows:Int = 15
    return min(bounds.size.width,bounds.size.height) / CGFloat(rows + 1)
}

//根据棋盘行列得到棋子坐标点
public func piecePosition(bounds: CGRect,row: Int,col: Int) -> CGPoint{
    let x = originX(bounds: bounds) + cellSide(bounds: bounds) * CGFloat(col)
    let y = originY(bounds: bounds) + cellSide(bounds: bounds) * CGFloat(row)
    return CGPoint(x: x, y: y)
}

//根据x,y坐标得到数组坐标
public func xyToColRow(bounds:CGRect,x: CGFloat,y: CGFloat) -> (Int,Int){
    
    let col = Int((x - originX(bounds: bounds)) / cellSide(bounds: bounds) + 0.5)
    let row = Int((y - originY(bounds: bounds)) / cellSide(bounds: bounds) + 0.5)
    return (row,col)
}

//判断是否五子连珠
 func judgeGame (newpoint : ChessPiece,pieces : [Int]) -> Int
{
    if (judgeHorizon(newpoint: newpoint, pieces: pieces) != 0)
    {
        return judgeHorizon(newpoint: newpoint, pieces: pieces)
    }
    else if (judgeVertical(newpoint: newpoint, pieces: pieces) != 0)
    {
        return judgeVertical(newpoint: newpoint, pieces: pieces)
    }
    else if (judgeRight(newpoint: newpoint, pieces: pieces) != 0)
    {
        return judgeRight(newpoint: newpoint, pieces: pieces)
    }
    else if(judgeLeft(newpoint: newpoint, pieces: pieces) != 0)
    {
        return judgeLeft(newpoint: newpoint, pieces: pieces)
    }
    return 0
}

//判断横向是否五子连珠
 func judgeHorizon (newpoint : ChessPiece,pieces : [Int]) -> Int
{
    
    let name = newpoint.name
    var count : Int = 1
    for i in newpoint.row * 15...newpoint.row * 15 + 13 {
       if(pieces[i] == name && pieces[i + 1] == name)
        {
           count = count + 1
       }
        else {
            count = 1
        }
        if count == 5
        {
            return name
        }
    }
    return 0
}

//判断竖向是否五子连珠
 func judgeVertical (newpoint : ChessPiece,pieces : [Int]) -> Int
{
    
    let name = newpoint.name
    var count : Int = 1
    for i in 0...13 {
        if(pieces[i * 15 + newpoint.col] == name && pieces[i * 15 + newpoint.col + 15] == name)
        {
           count = count + 1
       }
        else {
            count = 1
        }
        if count == 5
        {
            return name
        }
    }
    return 0
}

//判断右斜向是否五子连珠
func judgeRight(newpoint : ChessPiece,pieces : [Int]) -> Int
{

    let name = newpoint.name
    var count : Int = 1

    var num : Int = newpoint.row * 15 + newpoint.col

    while ( num % 15 != 0){
        if(num - 16) >= 0
        {
            num = num - 16
        }
        else {
            break;
        }
    }

    while (num % 15 != 14) {
        if(num + 16) < 225{
            if(pieces[num] == name && pieces[num + 16] == name)
            {
               count = count + 1
           }
            else {
                count = 1
            }
            if count == 5
            {
                return name
            }
            num = num + 16
        }
        else{
            break;
        }
    }
    return 0
}

//判断左斜是否五子连珠
func judgeLeft(newpoint : ChessPiece,pieces : [Int]) -> Int
{

    let name = newpoint.name
    var count : Int = 1

    var num : Int = newpoint.row * 15 + newpoint.col

    while ( num % 15 != 14){
        if(num - 14) >= 0
        {
            num = num - 14
        }
        else {
            break;
        }
    }

    while (num % 15 != 0) {
        if(num + 14) < 225{
            if(pieces[num] == name && pieces[num + 14] == name)
            {
               count = count + 1
           }
            else {
                count = 1
            }
            if count == 5
            {
                return name
            }
            num = num + 14
        }
        else{
            break;
        }
    }
    return 0
}

//悔棋
func regret(newpoint :inout ChessPiece,pieces : inout [Int],downpoint : inout [ChessPiece],turn :inout Bool)  {
    pieces[newpoint.row * 15 + newpoint.col] = 0
    if(!downpoint.isEmpty){
        turn.toggle()
        downpoint.remove(at: downpoint.count - 1)
        if(!downpoint.isEmpty){
            newpoint.col = downpoint.last!.col
            newpoint.row = downpoint.last!.row
            newpoint.name = downpoint.last!.name
        }
        
        else{
           Text("无法悔棋！")
        }
    }
}
    
//重新开始
func rePlay(newpoint :inout ChessPiece,pieces : inout [Int],downpoint : inout [ChessPiece],turn :inout Bool)  {
    newpoint = ChessPiece.init()
    pieces = Array(repeating: 0, count: 225)
    downpoint = []
    turn = true
}
    
    struct Board :Shape{
        let bounds: CGRect
        func path(in rect :CGRect) -> Path {
            var path = Path()
            
            let cols:Int = 15
            let rows:Int = 15
            let oriX:CGFloat = originX(bounds: bounds)
            let oriY:CGFloat = originY(bounds: bounds)
            let cellLth :CGFloat = cellSide(bounds: bounds)
            
            for row in 0..<rows{
                path.move(to:CGPoint(x: oriX,y: oriY + CGFloat(row) * cellLth ))
                path.addLine(to: CGPoint(x: oriX + cellLth * CGFloat(cols - 1),y: oriY + CGFloat(row) * cellLth))
            }
            
            for col in 0..<cols{
                path.move(to: CGPoint(x: oriX + CGFloat(col) * cellLth , y: oriY))
                path.addLine(to: CGPoint(x: oriX + CGFloat(col) * cellLth, y: oriY + CGFloat(rows - 1) * cellLth))
            }
            return path
        }
        
    }

