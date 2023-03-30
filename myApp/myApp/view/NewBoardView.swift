//
//  NewBoardView.swift
//  myApp
//
//  Created by 陈慧琦 on 2023/3/28.
//

import SwiftUI


struct NewBoardView: View {
    @Binding var active : Bool
    
    @State var xpos : CGFloat = 0
    @State var ypos : CGFloat = 0
    @State var xystr : String = "asd"
    
    @State var pieces = Array(repeating: 0, count: 225)
    @State var turn : Bool = true
    @State var newpoint : ChessPiece
    @State var downpoint : [ChessPiece] = [ChessPiece]()
    
    var body: some View {
        VStack {
            Text("x: \(xpos) ,y:\(ypos) -> \(xystr)"  )
            ZStack {
                GeometryReader{geo in
                        ChessBoardView()
                        .onTapGesture { pos in

                            self.xpos = pos.x
                            self.ypos = pos.y
                            let (toRow ,toCol) = xyToColRow(bounds: geo.frame(in: .local), x: self.xpos, y: self.ypos)
                            xystr = "x:\(toRow),y:\(toCol)"
                            
                             
                            
                            //如果点击位置未落子则生成子
                            if (pieces[toRow * 15 + toCol] == 0){
                                newpoint.col = toCol
                                newpoint.row = toRow
                                newpoint.name = turn ? 1 : -1
                                downpoint.append(newpoint)
                                pieces[toRow * 15 + toCol] = turn ? 1 : -1
                                turn.toggle()
                            }
                            
                        }
                   
                    //刷新棋盘
                    ForEach(0...224,id: \.self){ i in
                        if pieces[i] != 0 {
                            Image(pieces[i]==1 ? "black":"white")
                                .resizable()
                                .frame(width: cellSide(bounds: geo.frame(in: .local)),height: cellSide(bounds: geo.frame(in: .local)))
                                .position(piecePosition(bounds: geo.frame(in: .local), row: i / 15, col: i % 15))
                        }
                        
                    }
                    
                    //判断游戏输赢
                    let x = judgeGame(newpoint: newpoint, pieces: pieces)
                    if(x != 0){
                        Text( x == 1 ? "黑方胜利！" : "白方胜利！")
                    }
                    
                    

                       
                }
            }
            HStack {
                Button(action: {
                                regret(newpoint: &newpoint, pieces: &pieces, downpoint: &downpoint,turn: &turn)
                            }, label: {
                                Text("悔棋")
                                    .font(.title2)
                            })
                .frame(width: 120,height: 70)
                .background(Color.yellow)
            .cornerRadius(10)
                
                Button(action: {
                                rePlay(newpoint: &newpoint, pieces: &pieces, downpoint: &downpoint, turn: &turn)
                            }, label: {
                                Text("重玩")
                                    .font(.title2)
                            })
                .frame(width: 120,height: 70)
                .background(Color.yellow)
                .cornerRadius(10)
            }
           
        }
    }
}






struct NewBoardView_Previews: PreviewProvider {
    static var previews: some View {
        NewBoardView(active: .constant(true), newpoint: .init())
    }
}
