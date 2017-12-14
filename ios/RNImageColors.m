#import "UIImage+Utilities.h"
#import "RNImageColors.h"
#import <React/RCTUtils.h>
#import <React/RCTLog.h>
#import <React/RCTConvert.h>

@implementation RNImageColors

//- (dispatch_queue_t)methodQueue
//{
//    return dispatch_get_main_queue();
//}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getColorFromImage:(NSDictionary *)options
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSString *imagePath = options[@"path"];
    CGFloat sectionsX = [RCTConvert CGFloat:options[@"sectionsX"]];
    CGFloat sectionsY = [RCTConvert CGFloat:options[@"sectionsY"]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath])
    {
        NSError *error;
        reject(@"file-not-fount", @"That file was not found", error);
        return;
    }
    
    
    RCTLogInfo(@"getColorFromImage file: %@ sectionsX: %f sectionsY: %f", imagePath, sectionsX, sectionsY);
    
    NSMutableArray *colors = [NSMutableArray array];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    CGFloat widthSize = floorf(image.size.width / sectionsX);
    CGFloat heightSize = floorf(image.size.height / sectionsY);
    
    CGImageRef fullImage = [image CGImage];
    
    for (int y = 0; y < sectionsY; ++y) {
        for (int x = 0; x < sectionsX; ++x) {
            CGFloat xPos = x * widthSize;
            CGFloat yPos = y * heightSize;
            
            CGImageRef tileImage = CGImageCreateWithImageInRect(fullImage, CGRectMake(xPos, yPos, widthSize, heightSize));
            UIColor *currentColor = [[UIImage imageWithCGImage:tileImage] averageColor];
            CGImageRelease(tileImage);
            
            NSString *hexColor = RCTColorToHexString(currentColor.CGColor);
            
            [colors addObject:hexColor];
        }
    }
    
    // I guess i don't need to release it
    // CGImageRelease(fullImage);
    
    if (colors) {
        NSLog(@"resolve");
        resolve(colors);
    } else {
        NSError *error;
        reject(@"failed", @"There were no colors", error);
    }
}

@end

