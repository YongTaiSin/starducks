import SwiftUI

enum Size: CaseIterable {
    case M,L,XL
    
    var desc: [String] {
        switch self {
        case .M:
            return ["m-cup","中杯"]
        case .L:
            return ["l-cup","大杯"]
        case .XL:
            return ["xl-cup","特大杯"]
        }
    }
}

struct SizeOptionsView: View {
    @Binding var selection : Int
    
    var body: some View {
        HStack(alignment: .bottom) {
            
            ForEach(Size.allCases.indices) { (index) in
                VStack {
                    Image(Size.allCases[index].desc.first!).renderingMode(.template)
                    Text(LocalizedStringKey(Size.allCases[index].desc[1])).font(.system(size: 20))
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .onTapGesture {
                    selection = index
                }
                .foregroundColor(selection == index ? Color.accentColor : Color("unselect"))
                
            }
            
        }.overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundColor(Color(.separator))
        )
        
        
        
    }
}

struct SizeOptionsView_Previews: PreviewProvider {
    struct testView1: View {
        @State var selection : Int
        
        var body: some View {
            SizeOptionsView(selection: $selection)
        }
    }
    
    static var previews: some View {
        Group {
            testView1(selection: 2)
            SizeOptionsView(selection: .constant(0))
                .preferredColorScheme(.dark)
                .environment(\.locale, .init(identifier:"zh"))
            SizeOptionsView(selection: .constant(1))
                .environment(\.locale, .init(identifier:"ar-sa"))
                .environment(\.layoutDirection, .rightToLeft)

        }.previewLayout(.sizeThatFits)
    }
}
