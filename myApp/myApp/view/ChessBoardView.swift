//
//  ChessBoardView.swift
//  myApp
//
//  Created by 陈慧琦 on 2023/3/30.
//

import SwiftUI

struct ChessBoardView: View {
    var body: some View {
        GeometryReader{geo in
            Circle()
                .frame(width: cellSide(bounds: geo.frame(in: .local))/2,height: cellSide(bounds: geo.frame(in: .local))/2)
                .position(x:originX(bounds: geo.frame(in: .local)) + 7 * cellSide(bounds: geo.frame(in: .local)) ,y: originY(bounds: geo.frame(in: .local)) + 7 * cellSide(bounds: geo.frame(in: .local)))
            
            Circle()
                .frame(width: cellSide(bounds: geo.frame(in: .local))/2,height: cellSide(bounds: geo.frame(in: .local))/2)
                .position(x:originX(bounds: geo.frame(in: .local)) + 3 * cellSide(bounds: geo.frame(in: .local)) ,y: originY(bounds: geo.frame(in: .local)) + 3 * cellSide(bounds: geo.frame(in: .local)))
            
            Circle()
                .frame(width: cellSide(bounds: geo.frame(in: .local))/2,height: cellSide(bounds: geo.frame(in: .local))/2)
                .position(x:originX(bounds: geo.frame(in: .local)) + 11 * cellSide(bounds: geo.frame(in: .local)) ,y: originY(bounds: geo.frame(in: .local)) + 3 * cellSide(bounds: geo.frame(in: .local)))
            
            Circle()
                .frame(width: cellSide(bounds: geo.frame(in: .local))/2,height: cellSide(bounds: geo.frame(in: .local))/2)
                .position(x:originX(bounds: geo.frame(in: .local)) + 3 * cellSide(bounds: geo.frame(in: .local)) ,y: originY(bounds: geo.frame(in: .local)) + 11 * cellSide(bounds: geo.frame(in: .local)))
            
            Circle()
                .frame(width: cellSide(bounds: geo.frame(in: .local))/2,height: cellSide(bounds: geo.frame(in: .local))/2)
                .position(x:originX(bounds: geo.frame(in: .local)) + 11 * cellSide(bounds: geo.frame(in: .local)) ,y: originY(bounds: geo.frame(in: .local)) + 11 * cellSide(bounds: geo.frame(in: .local)))
            Board(bounds: geo.frame(in: .local))
                .stroke(Color.black)
        }
    }
}

struct ChessBoardView_Previews: PreviewProvider {
    static var previews: some View {
        ChessBoardView()
    }
}
