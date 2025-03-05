#import <Foundation/Foundation.h>

// File system error codes
typedef NS_ENUM(NSInteger, MCOFSError) {
    MCOFSErrorNone = 0,
    MCOFSErrorInvalidPath,
    MCOFSErrorDiskFull,
    MCOFSErrorFileNotFound,
    MCOFSErrorPermissionDenied,
    MCOFSErrorAlreadyExists
};

// File attributes structure
@interface MCOFileAttributes : NSObject
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSDate *modificationDate;
@property (nonatomic, assign) uint64_t fileSize;
@property (nonatomic, assign) BOOL isDirectory;
@property (nonatomic, strong) NSString *owner;
@property (nonatomic, assign) uint32_t permissions;
@end

// Main file system class
@interface MCOFileSystem : NSObject

+ (instancetype)sharedInstance;

- (MCOFSError)formatDiskAtPath:(NSString *)path;
- (MCOFSError)mountDiskAtPath:(NSString *)path;
- (MCOFSError)unmountDisk;

- (MCOFSError)createFileAtPath:(NSString *)path;
- (MCOFSError)createDirectoryAtPath:(NSString *)path;
- (MCOFSError)deleteItemAtPath:(NSString *)path;
- (MCOFSError)moveItemAtPath:(NSString *)sourcePath toPath:(NSString *)destinationPath;
- (MCOFSError)copyItemAtPath:(NSString *)sourcePath toPath:(NSString *)destinationPath;

- (NSData *)readFileAtPath:(NSString *)path error:(MCOFSError *)error;
- (MCOFSError)writeData:(NSData *)data toFileAtPath:(NSString *)path;

- (MCOFileAttributes *)attributesOfItemAtPath:(NSString *)path error:(MCOFSError *)error;
- (NSArray<NSString *> *)contentsOfDirectoryAtPath:(NSString *)path error:(MCOFSError *)error;

@end 