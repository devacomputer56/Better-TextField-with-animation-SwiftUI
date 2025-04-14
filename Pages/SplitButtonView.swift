
import SwiftUI

struct SplitButtonView: View {
    @State private var isSplit = false
    @State private var shakeOffset: CGFloat = 0
    @State private var text: String = ""
    @State var showFirst: Bool = true
    @State var showSecond: Bool = true
    @State var showThird: Bool = true
    @FocusState var focus: Bool
    @State private var isPressed = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("Image Asset 1")
                    .ignoresSafeArea()
                    .onTapGesture{
                        if isSplit == true{
                            isSplit = false
                            showFirst = true
                            showSecond = true
                            showThird = true
                            self.focus = false
                        }
                    }
                VStack {
                    HStack(spacing: 10) {
                            
                     NavigationLink{
                         
                     }label: {
                         ZStack{
                             Capsule()
                                 .frame(width: 80, height: 30)
                                 .foregroundStyle(.ultraThinMaterial)
                             Image(systemName: "apple.intelligence")
                                 .foregroundStyle(colorScheme == .dark ? .white : .black)
                         }
                         .opacity(showFirst ? 1 : 0)
                         .scaleEffect(showFirst ? 1 : 0.5)
                         .animation(.easeOut(duration: 0.5), value: showFirst)
                     }
                        
                        NavigationLink{
                            
                        }label: {
                            ZStack{
                                Capsule()
                                    .frame(width: 80, height: 30)
                                    .foregroundStyle(.ultraThinMaterial)
                                Image(systemName: "camera")
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                            }
                            .offset(x: showSecond ? 0 : -30)
                            .opacity(showSecond ? 1 : 0)
                            .animation(.easeOut(duration: 0.3).delay(0.3), value: showSecond)
                        }
                        
                        NavigationLink{
                            
                        } label: {
                            ZStack{
                                Capsule()
                                    .frame(width: 80, height: 30)
                                    .foregroundStyle(.ultraThinMaterial)
                                Image(systemName: "hand.thumbsup.fill")
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                            }
                            .offset(x: showThird ? 0 : -30)
                            .opacity(showThird ? 1 : 0)
                            .animation(.easeOut(duration: 0.05).delay(0.6), value: showThird)
                        }
                    }
                    HStack(spacing: isSplit ? 10 : 0) {
                        // 左側のボタン or テキストフィールド
                        if isSplit {
                            TextField("入力してください", text: $text)
                                .focused($focus)
                                .padding(.vertical)
                                .padding(.horizontal, 4)
                                .background(
                                    ButtonPart(isLeft: false)
                                        .cornerRadius(15)
                                )
                                .frame(width: 250, height: 60)
                                .offset(x: isSplit ? -10 : 0)
                                .offset(x: shakeOffset)
                        } else {
                            ButtonPart(isLeft: true)
                                .frame(width: 300, height: 60)
                                .cornerRadius(15)
                                .offset(x: shakeOffset)
                        }
                        
                        // 右側の小さいボタン
                        
                        ZStack{
                            ButtonPart(isLeft: false)
                            Image(systemName: "paperplane")
                        }
                        .frame(width: isSplit ? 50 : 0, height: isSplit ? 50 : 60)
                        .cornerRadius(isSplit ? 25 : 15)
                        .offset(x: isSplit ? 10 : 0)
                        .offset(x: -shakeOffset)
                        .opacity(isSplit ? 1 : 0) 
                        .scaleEffect(isPressed ? 1.2 : 1.0)
                        .onTapGesture{
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0)){
                                isPressed.toggle()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12){
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.4, blendDuration: 0)){
                                    isPressed.toggle()
                                }
                            }
                        }
                    }
                    .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isSplit)
                }
                .frame(width: 200, height: 60)
                .onTapGesture {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32){
                        self.focus = true
                    }
                    if isSplit == false{
                        withAnimation {
                            isSplit.toggle()
                        }
                        showFirst = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                            showSecond = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
                            showThird = false
                        }
                        
                    } else {
                    }
                }
            }
        }
    }
    
    func startShaking() {
        let shakeAmount: CGFloat = 8
        withAnimation(Animation.easeInOut(duration: 0.1).repeatCount(1, autoreverses: true)) {
            shakeOffset = shakeAmount
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                shakeOffset = 0
            }
        }
    }
}

struct ButtonPart: View {
    let isLeft: Bool
    var body: some View {
        Rectangle()
            .foregroundStyle(.ultraThinMaterial)
            
    }
}




