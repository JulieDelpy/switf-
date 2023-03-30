//
//  PvpView.swift
//  myApp
//
//  Created by 陈慧琦 on 2023/3/27.
//


import SwiftUI


var chesses = [[Int]]()

struct PvpView: View {
    @State private var imageWidth: CGFloat = UIScreen.main.bounds.width
    @State private var location = CGPoint.zero
    var body: some View {
        VStack{
            Text("Location: \(location.x), \(location.y)")
           Image("board")
                .resizable()
                .frame(width: imageWidth,height: imageWidth)
                .coordinateSpace(name: "chess")
                .onTapGesture {location in
                    self.location = location
                }
                
            Image("white")
                .resizable()
                .frame(width:20,height: 20 )
                .position(x:22,y: 22)
            
        }
        
    }
    
}

struct PvpView_Previews: PreviewProvider {
    static var previews: some View {
        PvpView()
    }
}
