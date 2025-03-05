import SwiftUI

struct FormatDiskView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: FileSystemViewModel
    @State private var path: String = ""
    @State private var showingFilePicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Format Disk")
                .font(.title)
            
            HStack {
                TextField("Disk Path", text: $path)
                Button("Browse") {
                    showingFilePicker = true
                }
            }
            .padding()
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                Button("Format") {
                    viewModel.formatDisk(path: path)
                    dismiss()
                }
                .disabled(path.isEmpty)
            }
        }
        .padding()
        .frame(width: 400, height: 200)
        .fileImporter(isPresented: $showingFilePicker,
                     allowedContentTypes: [.data]) { result in
            if case .success(let url) = result {
                path = url.path
            }
        }
    }
} 