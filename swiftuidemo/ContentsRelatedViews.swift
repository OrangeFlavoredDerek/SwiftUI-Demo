//
//  ContentsRelatedViews.swift
//  swiftuidemo
//
//  Created by 陳峻琦 on 20/1/2022.
//

import SwiftUI

struct ContentsRelatedViews: View {
    @State private var input: String = ""
    @State private var showReminderOnMainScreen: Bool = false
    @State private var sendOutNoticification: Bool = false
    @State private var selectedDuration: Int = 0
    var targetDuration: [String] = ["15 mins", "30 mins", "1 hour", "2 hours", "3 hours"]
    var columns: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: 350), spacing: 15)]
    var array: [Row] = [
        Row(label: "项目总用时", image: "clock", value: "50", unit: "mins"),
        Row(label: "当前进行的项目", image: "circles.hexagonpath.fill", value: "3", unit: "个"),
        Row(label: "获得成就勋章", image: "star.fill", value: "5", unit: "枚")
    ]
    
    var body: some View {
        TabView {
            //MARK: List
            List  {
                TextField("Input", text: $input)
                Text(input)
                ForEach(0..<5) { items in
                    CardView()
                }
            }
            .tabItem {
                Image(systemName: "doc.append")
                Text("项目")
            }
            
            //MARK: Grid
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                        ForEach(array) { row in
                            GroupBox(label: Label(row.label, systemImage: row.image)) {
                                ValueView(value: row.value, unit: row.unit)
                            }
                            .groupBoxStyle(DefaultGroupBoxStyle())
                        }
                    }
                    .padding([.top, .bottom])
                }
            }
            .tabItem {
                Image(systemName: "textformat.123")
                Text("统计")
            }
            
            //MARK: Form
            NavigationView {
                Form {
                    Section(header: Text("每日目标")) {
                        Toggle(isOn: $showReminderOnMainScreen) {
                            Text("显示目标")
                        }
                        
                        Toggle(isOn: $sendOutNoticification) {
                            Text("推送提醒")
                        }
                        
                        Picker(selection: $selectedDuration) {
                            ControlRelatedViews()
                                .navigationBarTitle("View")
                        } label: {
                            Text("目标时常")
                            ForEach(0..<targetDuration.count) {
                                Text(targetDuration[$0])
                            }
                        }
                    }
                    
                    Section {
                        Button {
                            
                        } label: {
                            Text("帮助指南 ")
                        }

                    } header: {
                        Text("帮助与反馈")
                    }
                }
                .navigationBarTitle("设置")
            }
            .tabItem {
                Image(systemName: "gearshape")
                Text("设置")
            }
        }
    }
}

//统计面板中的数值子视图
struct ValueView: View {
    var value: String
    var unit: String
    var size: CGFloat = 1
    
    var body: some View {
        HStack {
            Text(value)
                .font(.system(size: 24*size, weight: .bold, design: .rounded)) + Text(" \(unit)").font(.system(size: 14 * size, weight: .semibold, design: .rounded)).foregroundColor(.secondary)
            Spacer()
            
        }
    }
}

//统计面板中的数值数据结构
struct Row: Identifiable, Hashable {
    var id = UUID()
    var label: String
    var image: String
    var value: String
    var unit: String
}

//项目面板中的默认卡片
struct CardView: View {
    var body: some View {
        HStack {
            Image("icon")
                .resizable()
                .frame(width: 150, height: 150, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .shadow(radius: 10)
            VStack(alignment: .leading) {
                Text("SwiftUI demo")
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 5)
                Spacer()
                Text("SwiftUI")
                    .font(.body)
                    .foregroundColor(.gray)
                Text("Demo")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding(.leading)
        }
        .frame(height: 160)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding(.vertical, 5)
    }
}

struct ContentsRelatedViews_Previews: PreviewProvider {
    static var previews: some View {
        ContentsRelatedViews()
    }
}
