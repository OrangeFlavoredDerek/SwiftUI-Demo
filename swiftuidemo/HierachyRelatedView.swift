//
//  HierachyRelatedView.swift
//  swiftuidemo
//
//  Created by 陳峻琦 on 14/1/2022.
//

import SwiftUI

struct HierachyRelatedView: View {
    let circleRadius: CGFloat = 62
    let name: [String] = ["天狗", "爆款", "国际", "海外", "超市", "充值", "机票", "金币", "拍卖", "吃货", "分类", "美食", "健康", "生活", "汽车", "闲猪", "会员", "门票", "土货", "鲜食"]
    @State var showModal: Bool = false
    @State var showActionSheet: Bool = false
    @State var showAlert1: Bool = false
    @State var showAlert2: Bool = false
    
    var body: some View {
        TabView {
            //MARK: 滑动视图
            GeometryReader { fullView in
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { value in
                        HStack {
                            ForEach((0..<20), id: \.self) { index in
                                GeometryReader { geo in
                                    VStack {
                                        let distAbs = abs(fullView.frame(in: .global).midX - geo.frame(in: .global).midX)
                                        let centered = isCentered(distAbs: distAbs)
                                        
                                        ZStack {
                                            Image("\(index)")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .font(.system(size: circleRadius))
                                        }
                                        .scaleEffect(x: centered ? 1 : 0.7, y: centered ? 1 : 0.7)
                                        Text("\(name[index])")
                                            .font(centered ? .system(size: 20, weight: .bold, design: .default) : .system(size: 15, weight: .semibold, design: .default))
                                    }
                                    .id(index)
                                }
                                .frame(width: circleRadius, height: circleRadius*2, alignment: .center)
                            }
                            .animation(.easeOut, value: 0.1)
                        }
                        .onAppear {
                            value.scrollTo(5)
                        }
                    }
                }
                .foregroundColor(.black)
                .padding()
            }
            .foregroundColor(.orange)
            .tabItem {
                Image(systemName: "scroll")
                Text("Scroll")
            }
            
            //MARK: 导航视图
            NavigationView  {
                VStack {
                    VStack(spacing: 30) {
                        NavigationLink {
                            ShapeRelatedView()
                        } label: {
                            HStack {
                                Image(systemName: "star")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                                    .shadow(radius: 10)
                                VStack(alignment: .leading) {
                                    Text("demo")
                                        .font(.title2)
                                        .bold()
                                        .padding(.bottom, 5)
                                    Text("SwiftUI")
                                        .font(.body)
                                        .foregroundColor(.gray)
                                    HStack {
                                        Spacer()
                                        Image(systemName: "arrowshape.turn.right")
                                            .font(.system(size: 16, weight: .bold))
                                    }
                                }
                                .padding(.leading)
                            }
                            .frame(maxHeight: 120)
                            .cardStyle()
                        }
                    }
                }
                .navigationBarTitle("项目列表", displayMode: .automatic)
                .navigationBarItems(leading:
                                        NavigationLink(destination: {
                    ControlRelatedView()
                }, label: {
                    Text("skip to CRV")
                })
                                        , trailing: Button("right") {
                    
                })
            }
            .tabItem {
                Image(systemName: "network")
                Text("Navigation")
            }
            
            //MARK: 弹窗视图
            VStack(spacing: 50) {
                Button {
                    showModal.toggle()
                } label: {
                    Text("显示「长弹窗」")
                        .font(.headline)
                        .frame(width: 200)
                        .cardStyle()
                }
                .sheet(isPresented: $showModal) {
                    ShapeRelatedView()
                }
                
                Button {
                    showActionSheet.toggle()
                } label: {
                    Text("显示「行动列表」")
                        .font(.headline)
                        .frame(width: 200)
                        .cardStyle()
                }
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(title: Text("要执行什么操作"), message: Text("补充文字说明"), buttons: [
                        .default(Text("添加至收藏夹")) { },
                        .destructive(Text("删除项目"), action: {
                            
                        }),
                        .cancel()
                    ])
                }

            }
            .tabItem {
                Image(systemName: "square.stack")
                Text("Modal")
            }
            
            //MARK: 警告视图
            VStack(spacing: 50) {
                Button {
                    showAlert1.toggle()
                } label: {
                    Text("显示「允许选择的警告」")
                        .font(.headline)
                        .frame(width: 200)
                        .cardStyle()
                }
                .alert(isPresented: $showAlert1) {
                    Alert(title: Text("删除"), message: Text("此操作会永久移除该文件，你确定继续吗？"), primaryButton: .destructive(Text("是")), secondaryButton: .destructive(Text("否")))
                }
                
                Button {
                    showAlert2.toggle()
                } label: {
                    Text("显示「通知型警告」")
                        .font(.headline)
                        .frame(width: 200)
                        .cardStyle()
                }
                .alert(isPresented: $showAlert2) {
                    Alert(title: Text("用时较长"), message: Text("执行该操作预计用时5分钟，请勿关闭应用"), dismissButton: .default(Text("我知道了")))
                }


            }
            .tabItem {
                Image(systemName: "exclamationmark.triangle")
                Text("Alert")
            }
        }
    }
    //辅助函数，通过距离中点的位置来判断滑动视图中被选中的按钮
    func isCentered(distAbs: CGFloat) -> Bool {
        distAbs < (circleRadius / 2 + 5) ? true : false
    }
}


struct HierachyRelatedView_Previews: PreviewProvider {
    static var previews: some View {
        HierachyRelatedView()
    }
}
