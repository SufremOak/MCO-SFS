import SwiftUI

struct FileRowView: View {
    let filename: String
    @State private var isHovered = false
    
    var body: some View {
        HStack {
            Image(systemName: "doc")
            Text(filename)
            Spacer()
        }
        .padding(.vertical, 4)
        .background(isHovered ? Color.gray.opacity(0.1) : Color.clear)
        .onHover { hovering in
            isHovered = hovering
        }
    }
} 