//
//  ForgotPasswordView.swift
//  IWish
//
//  Created by Viktoriya Kudryashova on 7/21/22.
//

//import SwiftUI
//
//struct ForgotPasswordView: View {
//
//    @Environment(\.presentationMode) var presentationMode
//    @State var email = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Email Address", text: $email)
//                    .disableAutocorrection(true)
//                    .autocapitalization(.none)
//                    .padding()
//                    .background(Color(.secondarySystemBackground))
//                    .cornerRadius(50)
//                    .frame(width: UIScreen.main.bounds.width - 40, height: 40)
//                    .padding()
//                Button {
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Text ("Send password reset")
////                        .cornerRadius(10)
//                    .frame(maxWidth:.infinity, maxHeight: 30)
////                    .frame(width: UIScreen.main.bounds.width - 60, height: 40)
//                        .padding()
//
//
//                }
//                    .foregroundColor(.black)
//                    .background(Color(.systemGray5))
//                    .cornerRadius(10)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(Color.gray.opacity(0.25))
//                        )
//
//            }.padding(.horizontal, 15)
//            .navigationTitle("Reset Password")
//            .toolbar {
//                Button {
//                    presentationMode.wrappedValue.dismiss()
//                } label: {
//                    Image(systemName: "xmark")
//                }.foregroundColor(.black)
//
//            }
//        }
//
//    }
//}
//
//struct ForgotPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForgotPasswordView()
//    }
//}

//import SwiftUI

//struct CategoriesView: View {
//  @ObservedObject var viewModel: CategoriesViewModel
//  @Environment(\.presentationMode) var presentationMode
//  @State private var isPresentingRateView: Bool = false
//  @State private var ratedRestaurantID: String = ""
//  @State private var isPresentingShareView: Bool = false
//  @State private var shareRestaurantID: String = ""
//  var body: some View {
//    let contentHeight: CGFloat = 100.0
//    NavigationView {
//      ZStack {
//        VStack {
//          List(viewModel.items, children: \.children) { row in
//            let item = row.item
//            if let categoryViewModel = item as? CategoryViewModel {
//              CategoryRow(viewModel: categoryViewModel)
//            } else if let ratingViewModel = item as? RatingViewModel {
//              RatingRow(viewModel: ratingViewModel)
//            }
//            else if let restaurantViewModel = item as? RestaurantViewModel,
//                    let restaurant = viewModel.getRestaurant(for: restaurantViewModel.id) {
//              ZStack {
//                RestaurantRow(viewModel: restaurantViewModel)
//                  .frame(height: contentHeight)
//                  .modifier(SwipeableModifier(
//                              leadingActions: [SwipeAction(
//                                                title: "Rate",
//                                                iconName: "star.fill",
//                                                onTap: {
//                                                  ratedRestaurantID = restaurantViewModel.restaurantID
//                                                  withAnimation {
//                                                    isPresentingRateView.toggle()
//                                                  }
//                                                })],
//                              contentHeight: contentHeight)
//                  )
//                NavigationLink(destination: RestaurantView(restaurant: restaurant)) {
//                  EmptyView()
//                }.buttonStyle(PlainButtonStyle())
//              }
//              .contextMenu(ContextMenu(menuItems: {
//                Button(action: {
//                  ratedRestaurantID = restaurantViewModel.restaurantID
//                  withAnimation {
//                    isPresentingRateView.toggle()
//                  }
//                }, label: {
//                  Image(systemName: "star.fill")
//                  Text("Rate")
//                })
//                Button(action: {
//                  self.shareRestaurantID = restaurantViewModel.restaurantID
//                  withAnimation {
//                    isPresentingShareView.toggle()
//                  }
//                }, label: {
//                  Image(systemName: "square.and.arrow.up")
//                  Text("Share")
//                })
//              }))
//            }
//          }
//        }
//        if isPresentingRateView {
//          RateView(isPresenting: $isPresentingRateView, restaurantID: ratedRestaurantID)
//            .transition(.opacity)
//        }
//      }
//    }
//    .onAppear {
//      self.viewModel.handleSceneAppeared()
//    }
//    .sheet(isPresented: $isPresentingShareView, content: {
//      ActivityController(activityItems: self.viewModel.getShareableItems(for: shareRestaurantID))
//    })
//  }
//}
//
//struct CategoriesView_Previews: PreviewProvider {
//  static var previews: some View {
//    let restaurantService = MockRestaurantService()
//    let dependencies = CategoriesViewModel.Dependencies(restaurantService: restaurantService)
//    return CategoriesView(viewModel: CategoriesViewModel(dependencies: dependencies))
//  }
//}
