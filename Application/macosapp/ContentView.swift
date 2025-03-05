import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FileSystemViewModel()
    @State private var selectedPath: String?
    @State private var showingFormatDialog = false
    @State private var showingMountDialog = false
    
    var body: some View {
        NavigationSplitView {
            Sidebar(selectedPath: $selectedPath)
        } detail: {
            if let path = selectedPath {
                FileListView(path: path)
            } else {
                Text("Select a directory")
                    .foregroundColor(.secondary)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: { showingMountDialog.toggle() }) {
                    Label("Mount Disk", systemImage: "externaldrive.connected")
                }
            }
            ToolbarItem {
                Button(action: { showingFormatDialog.toggle() }) {
                    Label("Format Disk", systemImage: "externaldrive.badge.plus")
                }
            }
        }
        .sheet(isPresented: $showingFormatDialog) {
            FormatDiskView(viewModel: viewModel)
        }
        .sheet(isPresented: $showingMountDialog) {
            MountDiskView(viewModel: viewModel)
        }
    }
}

struct Sidebar: View {
    @Binding var selectedPath: String?
    
    var body: some View {
        List(selection: $selectedPath) {
            NavigationLink(value: "/") {
                Label("Root", systemImage: "folder")
            }
            // Add more sidebar items as needed
        }
    }
}

struct FileListView: View {
    let path: String
    @StateObject private var viewModel = FileSystemViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.files, id: \.self) { file in
                FileRowView(filename: file)
            }
        }
        .onAppear {
            viewModel.loadFiles(path: path)
        }
    }
}

// Xcode only (uncomment if you're in Xcode)
// #Preview {
//    ContentView()
// }