//
//  ChildViews.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/18.
//

import SwiftUI

struct __RedView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var shouldPopToRootView : Bool
    
    var body: some View {
        ZStack {
            Color.red
            VStack {
                NavigationLink(destination: __BlueView(shouldPopToRootView: $shouldPopToRootView)) {
                    Text("To Blue")
                        .setContentButton(color: .blue)
                }
                .isDetailLink(false)
                
                NavigationLink(destination: __GreenView(shouldPopToRootView: $shouldPopToRootView)) {
                    Text("To Green")
                        .setContentButton(color: .green)
                }
                .isDetailLink(false)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                } ,label: {
                    Text("Pop")
                })
                .setContentButton(color: .black)
                
                Button(action: {
                    shouldPopToRootView = false
                } ,label: {
                    Text("Pop To Root")
                })
                .setContentButton(color: .black)
            }
        }
        .navigationBarTitle(Text("Red View"), displayMode: .inline)
    }
}

struct __GreenView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var shouldPopToRootView : Bool
    
    var body: some View {
        ZStack {
            Color.green
            VStack {
                NavigationLink(destination: __RedView(shouldPopToRootView: $shouldPopToRootView)) {
                    Text("To Red")
                        .setContentButton(color: .red)
                }
                .isDetailLink(false)
                
                NavigationLink(destination: __BlueView(shouldPopToRootView: $shouldPopToRootView)) {
                    Text("To Blue")
                        .setContentButton(color: .blue)
                }
                .isDetailLink(false)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                } ,label: {
                    Text("Pop")
                })
                .setContentButton(color: .black)
                
                Button(action: {
                    shouldPopToRootView = false
                } ,label: {
                    Text("Pop To Root")
                })
                .setContentButton(color: .black)
            }
        }
        .navigationBarTitle(Text("Green View"), displayMode: .inline)
    }
}

struct __BlueView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var shouldPopToRootView : Bool
    
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                NavigationLink(destination: __RedView(shouldPopToRootView: $shouldPopToRootView)) {
                    Text("To Red")
                        .setContentButton(color: .red)
                }
                .isDetailLink(false)
                
                NavigationLink(destination: __GreenView(shouldPopToRootView: $shouldPopToRootView)) {
                    Text("To Green")
                        .setContentButton(color: .green)
                }
                .isDetailLink(false)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                } ,label: {
                    Text("Pop")
                })
                .setContentButton(color: .black)
                
                Button(action: {
                    shouldPopToRootView = false
                } ,label: {
                    Text("Pop To Root")
                })
                .setContentButton(color: .black)
            }
        }
        .navigationBarTitle(Text("Blue View"), displayMode: .inline)
    }
}


struct _RedView: View {
    @Binding var path: [Path]
    
    var body: some View {
        ZStack {
            Color.red
            VStack {
                Button(action: {
                    path.append(.blue)
                } ,label: {
                    Text("To Blue")
                })
                .setContentButton(color: .blue)
                
                Button(action: {
                    path.append(.green)
                } ,label: {
                    Text("To Green")
                })
                .setContentButton(color: .green)
                
                Button(action: {
                    if path.isEmpty { return }
                    path.removeLast()
                } ,label: {
                    Text("Pop")
                })
                .setContentButton(color: .black)
                
                Button(action: {
                    path.removeAll()
                } ,label: {
                    Text("Pop To Root")
                })
                .setContentButton(color: .black)
            }
        }
        .navigationBarTitle(Text("Red View"), displayMode: .inline)
    }
}

struct _GreenView: View {
    @Binding var path: [Path]
    
    var body: some View {
        ZStack {
            Color.green
            VStack {
                Button(action: {
                    path.append(.red)
                } ,label: {
                    Text("To Red")
                })
                .setContentButton(color: .red)
                
                Button(action: {
                    path.append(.blue)
                } ,label: {
                    Text("To Blue")
                })
                .setContentButton(color: .blue)
                
                Button(action: {
                    if path.isEmpty { return }
                    path.removeLast()
                } ,label: {
                    Text("Pop")
                })
                .setContentButton(color: .black)
                
                Button(action: {
                    path.removeAll()
                } ,label: {
                    Text("Pop To Root")
                })
                .setContentButton(color: .black)
            }
        }
        .navigationBarTitle(Text("Green View"), displayMode: .inline)
    }
}

struct _BlueView: View {
    @Binding var path: [Path]
    
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Button(action: {
                    path.append(.red)
                } ,label: {
                    Text("To Red")
                })
                .setContentButton(color: .red)
                
                Button(action: {
                    path.append(.green)
                } ,label: {
                    Text("To Green")
                })
                .setContentButton(color: .green)
                
                Button(action: {
                    if path.isEmpty { return }
                    path.removeLast()
                } ,label: {
                    Text("Pop")
                })
                .setContentButton(color: .black)
                
                Button(action: {
                    path.removeAll()
                } ,label: {
                    Text("Pop To Root")
                })
                .setContentButton(color: .black)
            }
        }
        .navigationBarTitle(Text("Blue View"), displayMode: .inline)
    }
}


struct RedView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        ZStack {
            Color.red
            VStack {
                Button(action: {
                    navigationRouter.to(.blue)
                } ,label: {
                    Text("To Blue")
                })
                .setContentButton(color: .blue)
                
                Button(action: {
                    navigationRouter.to(.green)
                } ,label: {
                    Text("To Green")
                })
                .setContentButton(color: .green)
            }
            .setBackButtons()
        }
        .navigationBarTitle(Text("Red View"), displayMode: .inline)
    }
}

struct GreenView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        ZStack {
            Color.green
            VStack {
                Button(action: {
                    navigationRouter.to(.red)
                } ,label: {
                    Text("To Red")
                })
                .setContentButton(color: .red)
                
                Button(action: {
                    navigationRouter.to(.blue)
                } ,label: {
                    Text("To Blue")
                })
                .setContentButton(color: .blue)
            }
            .setBackButtons()
        }
        .navigationBarTitle(Text("Green View"), displayMode: .inline)
    }
}

struct BlueView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Button(action: {
                    navigationRouter.to(.red)
                } ,label: {
                    Text("To Red")
                })
                .setContentButton(color: .red)
                
                Button(action: {
                    navigationRouter.to(.green)
                } ,label: {
                    Text("To Green")
                })
                .setContentButton(color: .green)
            }
            .setBackButtons()
        }
        .navigationBarTitle(Text("Blue View"), displayMode: .inline)
    }
}
