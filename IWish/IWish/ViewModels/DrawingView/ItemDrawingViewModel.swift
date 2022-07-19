//
//  ItemDrawing.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/17/22.
//

import SwiftUI
import PencilKit

// it holds all drawing data
struct DrawingView: UIViewRepresentable {
    //to capture drawing for saving into albums
     @Binding var canvas : PKCanvasView
     @Binding var isDraw : Bool
     @Binding var type: PKInkingTool.InkType
     @Binding var color: Color
     //showing tool picker
     
     
     // updating inkType//
     
     var ink : PKInkingTool {
     PKInkingTool(type, color: UIColor(color))
     
     }
     let eraser = PKEraserTool(.bitmap)
     
     func makeUIView(context: Context) -> PKCanvasView {
         canvas.drawingPolicy = .anyInput
         canvas.tool = isDraw ? ink : eraser
         return canvas
     }
     
     func updateUIView(_ uiView: PKCanvasView, context: Context) {
         // updating tool when ever main view updates
         uiView.tool = isDraw ? ink : eraser
     }
 }
