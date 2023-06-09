//
//  ContentView.swift
//  CountDownTimer_01
//
//  Created by kimhongpil on 2023/06/09.
//

import SwiftUI

/**
 * UI 디자인 적용할 코드 :
 * - https://www.devtechie.com/community/public/posts/153881-count-down-timer-animation-swiftui
 */
struct ContentView: View {
    @State private var isActive = false
    @State private var timeRemaining = 10
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(self.isActive ? "..." : "!!!")
                .font(.title)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(Color.gray.opacity(0.5))
                .clipShape(Circle())
            
            Text("Time : \(timeRemaining)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(Color.black.opacity(0.75))
                .clipShape(Capsule())
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        self.stopTimer()
                    }
                    
                    if timeRemaining == 0 {
                        self.isActive = false
                    }
                }
            
            Divider()
                .padding(.vertical, 30)
            
            HStack(spacing: 20) {
                Button(action: {
                    self.pauseTimer()
                }, label: {
                    Text("Pause")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
                
                Button(action: {
                    self.startTimer()
                }, label: {
                    Text("Start")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.green)
                        .clipShape(Capsule())
                })
                
                Button(action: {
                    self.stopTimer()
                }, label: {
                    Text("Resume")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.orange)
                        .clipShape(Capsule())
                })
            }
        }
        .onAppear {
            self.stopTimer()
        }
        
    }
    
    func stopTimer() {
        self.isActive = false
        self.timeRemaining = 10
        self.timer.upstream.connect().cancel()
    }
    
    func pauseTimer() {
        self.isActive = false
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.isActive = true
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
