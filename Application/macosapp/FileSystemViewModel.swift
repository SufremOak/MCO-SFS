import Foundation

class FileSystemViewModel: ObservableObject {
    @Published var files: [String] = []
    @Published var error: String?
    
    private let fileSystem = MCOFileSystem.shared()
    
    func formatDisk(path: String) {
        let error = fileSystem.formatDisk(atPath: path)
        if error != .none {
            self.error = "Failed to format disk: \(error)"
        }
    }
    
    func mountDisk(path: String) {
        let error = fileSystem.mountDisk(atPath: path)
        if error != .none {
            self.error = "Failed to mount disk: \(error)"
        }
    }
    
    func loadFiles(path: String) {
        var fsError: MCOFSError = .none
        if let contents = fileSystem.contentsOfDirectory(atPath: path, error: &fsError) {
            files = contents
        } else {
            error = "Failed to load directory contents: \(fsError)"
            files = []
        }
    }
    
    func createFile(name: String, inDirectory path: String) {
        let fullPath = (path as NSString).appendingPathComponent(name)
        let error = fileSystem.createFile(atPath: fullPath)
        if error != .none {
            self.error = "Failed to create file: \(error)"
        }
        loadFiles(path: path)
    }
} 