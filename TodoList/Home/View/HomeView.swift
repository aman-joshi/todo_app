//
//  HomeView.swift
//  TodoList
//
//  Created by Aman Joshi on 17/07/21.
//

import SwiftUI

struct HomeView: View {

  @ObservedObject var viewModel = HomeVM(dataStorage: DataStorageFactory.get())

  var body: some View {
    NavigationView{

        VStack{

            HomeCalendarView()
                .padding(.vertical, 25)

            VStack{

                HStack{

                    Text("TASKS")
                        .fontWeight(.bold)

                    Spacer()

                    // going to use navigationLink...

                    NavigationLink(destination: AddTaskView()) {

                        Image(systemName: "plus")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .padding(.horizontal)
                    }
                }
                .padding(.leading)

                Divider()
                    .background(Color.black.opacity(0.8))
            }

            GeometryReader{_ in

              if !self.viewModel.todayTasks.isEmpty{

                    ScrollView(.vertical, showsIndicators: false) {

                        VStack{

                          ForEach(0..<self.viewModel.todayTasks.count,id: \.self){i in

                                HStack{

                                    Button(action: {

                                      self.viewModel.deleteTask(task: i)

                                    }) {

                                        Image(systemName: "checkmark.circle")
                                        .resizable()
                                        .frame(width: 22, height: 22)
                                        .foregroundColor(.green)
                                        .padding(.trailing,10)
                                    }

                                  Text(self.viewModel.todayTasks[i])


                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.top,20)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Todo",displayMode: .large)
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.bottom))
        .onAppear {

          self.viewModel.getTasks()
          self.viewModel.deleteOldTasks()
        }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
