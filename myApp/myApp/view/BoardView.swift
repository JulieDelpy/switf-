//
//  BoardView.swift
//  myApp
//
//  Created by 陈慧琦 on 2023/3/27.
//

import SwiftUI

 var chessArray = [[Int]]()



struct BoardView: View {
    @Binding var active : Bool
    @State private var location = CGPoint.zero
    var screenbound :CGRect = UIScreen.main.bounds
    let rows : Int = 15
    let columns : Int = 15
    var body: some View {
        let wd = screenbound.width - 20
        let vwd = wd/14
        VStack{
            Text("人机对战")
            Text("Location: \(location.x), \(location.y)")
            
            Spacer()
            //绘制15条横线
            Path{path in
                for i in 0 ..< 15{
                    path.move(to: CGPoint(x: CGFloat(CGFloat(i)*vwd), y: 0))
                    path.addLine(to: CGPoint(x:CGFloat(i)*vwd , y: wd))
                }
                //绘制15条竖线
                for i in 0 ..< 15{
                    path.move(to: CGPoint(x: 0, y: CGFloat(i)*vwd))
                    path.addLine(to: CGPoint(x: wd, y: CGFloat(i)*vwd))
                }
               
                 
                 
                
                    }
                    .stroke(Color.black, lineWidth:2)
                    .border(Color.brown,width:3)
                    .frame(width: wd,height: wd)
                    .background(Color.brown)
                    .onTapGesture {location in
                        self.location = location
                        
                    }
            Spacer()
            Button(action: {
                            self.active = false
                        }, label: {
                            Text("认输")
                                .font(.title2)
                        })
            .frame(width: 120,height: 70)
            .background(Color.yellow)
            .cornerRadius(10)
        }
        
    }
    

}




struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(active: .constant(true) )
    }
}
