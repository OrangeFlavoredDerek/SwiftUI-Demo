//
//  ContentView.swift
//  swiftuidemo
//
//  Created by 陳峻琦 on 11/1/2022.
//

import SwiftUI
import MapKit

//控制视图
struct ControlView: View {
    @State var toggleValue: Bool = true
    @State var slideValue: Double = 0.0
    @State var stepperValue: Int = 0
    @State var pickerValue: Int = 0
    @State var progressValue: Double = 0.5
    @State var selectedDate: Date = Date()
    @State var location: MKCoordinateRegion = MKCoordinateRegion(center: .init(latitude: 39.9130, longitude: 116.3907), latitudinalMeters: 1000, longitudinalMeters: 1000)
    var dateRange: ClosedRange<Date> {
        let min: Date = Calendar.current.date(byAdding: .day, value: -100, to: Date())!
        let max: Date = Calendar.current.date(byAdding: .day, value: 100, to: Date())!
        return min...max
    }
    
    var pickerOptions: [String] = ["iPhone", "iPad", "Mac"]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack {
                //MARK: toggle
                VStack(alignment: .leading) {
                    Text("开关")
                        .font(.headline)
                    Toggle("Toggle", isOn: $toggleValue)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .frame(height: 80)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.horizontal)
                
                //MARK: button
                VStack(alignment: .leading) {
                    Text("按钮")
                        .font(.headline)
                    Button {
                        print("this is a button")
                    } label: {
                        Image(systemName: "person.crop.circle.fill.badge.minus")
                            .font(.system(size: 16, weight: .bold, design: .default))
                        Text("Button")
                            .bold()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
                }
                .frame(height: 80)
                .padding()
                .background(.white)
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.trailing)
            }
            .padding(.bottom)
            
            //MARK: picker
            VStack(alignment: .leading) {
                Text("选择器")
                    .font(.headline)
                Picker(selection: $pickerValue) {
                    ForEach(0..<pickerOptions.count) { index in
                        Text(pickerOptions[index]).tag(index)
                    }
                } label: {
                    Text("Picker")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .cardStyle()
            
            //MARK: slider
            VStack(alignment: .leading) {
                Text("滑动条")
                    .font(.headline)
                HStack {
                    Image(systemName: "sun.min")
                    Slider(value: $slideValue, in: -5...5)
                    Image(systemName: "sun.max")
                }
            }
            .cardStyle()
            
            //MARK: stepper
            VStack(alignment: .leading) {
                Text("梯度控制")
                    .font(.headline)
                Stepper("当前数值：\(stepperValue)", value: $stepperValue, in: -5...5)
            }
            .cardStyle()
            
            //MARK: date picker
            VStack(alignment: .leading) {
                Text("日期选择")
                    .font(.headline)
                DatePicker("截止日期", selection: $selectedDate, displayedComponents: [.hourAndMinute, .date])
            }
            .cardStyle()
            
            HStack {
                //MARK: contextMenu
                VStack(alignment: .leading) {
                    Text("长按菜单")
                        .font(.headline)
                    VStack {
                        Image(systemName: "ellipsis.circle.fill")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .foregroundColor(.blue)
                            .frame(width: 80, height: 80, alignment: .center)
                        Text("长按菜单")
                            .bold()
                            .foregroundColor(.blue)
                    }
                    .contextMenu {
                        Button {
                            print("A")
                        } label: {
                            Text("A")
                        }
                        
                        Button {
                            print("B")
                        } label: {
                            Text("B")
                        }
                    }
                }
                .frame(height: 120)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.leading)
                
                //MARK: progressView
                VStack(alignment: .leading) {
                    Text("Pro")
                        .font(.headline)
                    Spacer()
                    ProgressView(value: progressValue)
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding([.leading, .top])
                    Spacer()
                }
                .frame(height: 120)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 3)
                
                //MARK: map
                VStack(alignment: .leading) {
                    Text("地图")
                        .font(.headline)
                    Map(coordinateRegion: $location)
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(15)
                }
                .frame(height: 120)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding(.trailing)
            }
            .padding(.bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView()
    }
}


struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 80)
            .padding()
            .background(.white)
            .cornerRadius(15)
            .shadow(radius: 3)
            .padding(.horizontal)
            .padding(.bottom)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardModifier())
    }
}
