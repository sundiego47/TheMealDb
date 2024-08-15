//
//  ContentView.swift
//  TheMealDb
//
//  Created by Scott Jenkins on 8/15/24.
//

import SwiftUI

struct DessertView: View {
    @StateObject private var viewModel = DessertListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.desserts) { dessert in
                NavigationLink(destination: DessertDetailView(viewModel: viewModel, dessertID: dessert.idMeal)) {
                    HStack {
                        if let url = URL(string: dessert.strMealThumb) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Text(dessert.strMeal)
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.loadDesserts()
            }
        }
    }
}

struct DessertDetailView: View {
    @ObservedObject var viewModel: DessertListViewModel
    let dessertID: String
    
    @State private var mealDetail: MealDetails?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let mealDetail = mealDetail {
                    // Display the thumbnail image
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    } placeholder: {
                        ProgressView()
                    }
                    .padding(.bottom, 10)
                    
                    // Display the meal name
                    Text(mealDetail.strMeal)
                        .font(.title)
                        .padding(.bottom, 10)
                    
                    // Display instructions
                    Text("Instructions")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text(mealDetail.strInstructions)
                        .padding(.bottom, 20)
                    
                    // Display ingredients only if there are any
                    let ingredients = mealDetail.ingredients
                    if !ingredients.isEmpty {
                        Text("Ingredients / Measurements")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        ForEach(mealDetail.ingredients.sorted(by: <), id: \.key) { ingredient, measurement in
                            HStack {
                                Text(ingredient)
                                Spacer()
                                Text(measurement)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                } else {
                    ProgressView("Loading...")
                }
            }
            .padding()
        }
        .navigationTitle(mealDetail?.strMeal ?? "Loading...")
        .task {
            mealDetail = await viewModel.loadMealDetails(id: dessertID)
        }
    }
}

#Preview {
    DessertView()
}
