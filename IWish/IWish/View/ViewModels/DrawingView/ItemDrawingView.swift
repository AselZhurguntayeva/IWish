//
//  ItemDrawingView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/17/22.
//

import SwiftUI
import PencilKit

struct ItemDrawingView: View {
    @ObservedObject var itemViewModel: ItemViewModel
    
    var body: some View {
        Home()
    }
}

struct ItemDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ItemDrawingView(itemViewModel: ItemViewModel())
    }
}

struct Home: View {
    
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color: Color = .black
    @State var type: PKInkingTool.InkType = .pencil
    @State var colorPicker = false
    
    //default is pen
    var body: some View {
        NavigationView {
            
            // drawing view
            DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $color)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    // saving image
                    saveImage()
                }, label: {
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.title)
                }), trailing: HStack(spacing: 15) {
                    Button(action: {
                        
                        // erase tool
                        isDraw = false
                    }) {
                        Image(systemName: "pencil.slash")
                            .font(.title)
                    }
                    //Menu for InkType and Color
                    Menu {
                        // Color picker
                        Button(action: {
                            colorPicker.toggle()
                        }) {
                            Label {
                                Text("Color")
                            } icon: {
                                Image(systemName: "eyedropper.full")
                            }
                        }
                        Button(action: {
                            //changing type
                            isDraw = true
                            type = .pencil
                        }) {
                            Label {
                                Text("Pencil")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        
                        Button(action: {
                            isDraw = true
                            type = .pen
                        }) {
                            Label {
                                Text("Pen")
                            } icon: {
                                Image(systemName: "pencil.tip")
                            }
                        }
                        Button(action: {
                            isDraw = true
                            type = .marker
                        }) {
                            Label {
                                Text("Marker")
                            } icon: {
                                Image(systemName: "highlighter")
                            }
                        }
                    } label: {
                        Image("menu")
                            .resizable()
                            .frame(width: 32, height: 32)
                            
                    }
                    
                })
                .sheet(isPresented: $colorPicker) {
                    ColorPicker("Pick Color", selection: $color)
                        .padding()
                }
        }
    }
    func saveImage() {
        // getting image from canvas
        
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        
        // saving to albums
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        // I need to go to info.plist -> Information Property List->Choose-> Privacy Library Usage Description -> In the value line type " allow to save drawings"
    }
}

