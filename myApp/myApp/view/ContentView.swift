//
//  ContentView.swift
//  myApp
//
//  Created by 陈敏杰 on 2023/3/22.
//

import SwiftUI


struct ContentView: View {
    @State private var isGoBoadView : Bool = false
    @State private var isGoNewBoadView : Bool = false
    
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                NavigationLink(destination: BoardView(active: self.$isGoBoadView),
                               isActive: self.$isGoBoadView,
                label: {
                    Button(action: {
                        self.isGoBoadView = true
                    }, label: {
                        Text("人机对战")
                            .font(.title)
                    })
                    .frame(width: 120,height: 70)
                    .background(Color.yellow)
                    .cornerRadius(10)
                })
               
                Spacer()
                
                NavigationLink(destination: NewBoardView(active: self.$isGoNewBoadView, newpoint: .init()),
                               isActive: self.$isGoNewBoadView,
                label: {
                    Button(action: {
                        self.isGoNewBoadView = true
                    }, label: {
                        Text("人人对战")
                            .font(.title)
                    })
                    .frame(width: 120,height: 70)
                    .background(Color.yellow)
                    .cornerRadius(10)
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("联机对战")
                        .font(.title)
                })
                .frame(width: 120,height: 70)
                .background(Color.yellow)
                .cornerRadius(10)
                
                Spacer()
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            
        }
    }
}
