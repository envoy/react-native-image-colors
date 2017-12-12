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
    CGFloat sections = [RCTConvert CGFloat:options[@"sections"]];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath])
    {
        NSError *error;
        reject(@"file-not-fount", @"That file was not found", error);
        return;
    }
    
    
    RCTLogInfo(@"getColorFromImage file: %@ sections: %f", imagePath, sections);
    
    NSMutableArray *colors = [NSMutableArray array];
    
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    CGFloat widthSize = floorf(image.size.width / sections);
    CGFloat heightSize = floorf(image.size.height / sections);
    
    CGImageRef fullImage = [image CGImage];
    
    for (int y = 0; y < sections; ++y) {
        for (int x = 0; x < sections; ++x) {
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

