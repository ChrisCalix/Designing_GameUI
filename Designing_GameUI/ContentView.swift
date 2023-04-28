//
//  ContentView.swift
//  Designing_GameUI
//
//  Created by Sonic on 28/4/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("Your Player")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "line.horizontal.3.decrease")
                        .font(.title)
                        .foregroundColor(.white)
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 60)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(data) { character in
                        Card(data: character)
                    }
                }
                .padding(.bottom)
            }
            
        }
        .background(LinearGradient(gradient: .init(colors: [Color("primary1"),Color("primary2")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct Card: View {
    
    var data: Player
    
    var body: some View {
        HStack {
            Image(self.data.image)
                .resizable()
                .frame(width: UIScreen.main.bounds.width/1.8)
            
            Spacer()
            
            VStack(spacing: 20) {
                
                Spacer(minLength: 0)
                
                Image(systemName: "bolt.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        ZStack {
                            
                            self.data.color
                            
                            Circle()
                                .stroke(Color.black.opacity(0.1), lineWidth: 5)
                            
                            Circle()
                                .stroke(Color.white, lineWidth: 5)
                        }
                            .rotationEffect(.init(degrees: -90))
                    )
                    .clipShape(Circle())
                
                Image(systemName: "suit.heart.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        ZStack {
                            
                            self.data.color
                            
                            Circle()
                                .stroke(Color.black.opacity(0.1), lineWidth: 5)
                            
                            Circle()
                                .trim(from: 0, to: self.data.powers[0])
                                .stroke(Color.white, lineWidth: 5)
                        }
                            .rotationEffect(.init(degrees: -90))
                    )
                    .clipShape(Circle())
                
                Image(systemName: "hammer.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        ZStack {
                            
                            self.data.color
                            
                            Circle()
                                .stroke(Color.black.opacity(0.1), lineWidth: 5)
                            
                            Circle()
                                .trim(from: 0, to: self.data.powers[1])
                                .stroke(Color.white, lineWidth: 5)
                        }
                            .rotationEffect(.init(degrees: -90))
                    )
                    .clipShape(Circle())
                
                Spacer(minLength: 0)
                NavigationLink(destination: Detail(data: self.data)) {
                    Text("See Details")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 25)
                        .background(Capsule().stroke(Color.white, lineWidth: 2))
                }
                .offset(y: -35)
            }
            .padding(.trailing)
        }
        .frame(height: 290)
        .background(
            Color.white.opacity(0.2)
                .cornerRadius(25)
            // Ading 3D angle view
                .rotation3DEffect(
                    .init(degrees: 20),
                    axis: (x: 0, y: -1, z:0)
                )
            // Trimming the view
                .padding(.vertical, 35)
                .padding(.trailing, 25)
        )
    }
}

//Adding detail View
struct Detail: View {
    
    var data: Player
    @Environment(\.presentationMode) var present
    
    var body: some View {
        ScrollView {
            
            VStack {
                ZStack {
                    HStack {
                        Button {
                            // Pop the view when back button is pressed
                            self.present.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "circle.grid.2x2.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Text("Overview")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding()
                
                Image(self.data.image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width-30, height: UIScreen.main.bounds.height/2)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(30)
                
                Text(self.data.name)
                    .fontWeight(.bold)
                    .font(.system(size: 55))
                    .foregroundColor(.white)
                    .padding(.top)
                
                Text(self.data.description)
                    .foregroundColor(.white)
                    .padding(.top)
                
                HStack(spacing: 20) {
                    
                    Button {
                        
                    } label: {
                        Text("Add Favourites")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width/2) - 30)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Play Now")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width/2) - 30)
                            .background(
                                Color("primary2")
                            )
                            .clipShape(Capsule())
                    }
                }
                .padding(.top, 30)
                
                Spacer()
            }
            
        }.background(LinearGradient(gradient: .init(colors: [Color("primary3"), Color("primary4")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

// MARK: Mock values
struct Player: Identifiable {
    
    var id: Int
    var powers: [CGFloat]
    var image: String
    var name: String
    var color: Color
    var description: String
}

var data = [
    Player(id: 0, powers: [0.2, 0.5, 0.9], image: "wo1", name: "Barbarian Kind", color: Color("primary1"), description: "Troops are offensive units that are used to attack the villages of otger players. /n However, they can also be found on defense in certain Buildings, such as the Clan and Gauard Post."),
    Player(id: 1, powers: [0.3, 0.5, 0.6], image: "wo2", name: "Archer", color: Color("primary2"), description: "Troops are offensive units that are used to attack the villages of otger players. /n However, they can also be found on defense in certain Buildings, such as the Clan and Gauard Post."),
    Player(id: 2, powers: [0.5, 0.4, 0.8], image: "wo3", name: "Wizard", color: Color("primary3"), description: "Troops are offensive units that are used to attack the villages of otger players. /n However, they can also be found on defense in certain Buildings, such as the Clan and Gauard Post.")
]
