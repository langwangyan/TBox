//
//  TBImageUtil.m
//  TBox
//
//  Created by 王言 on 2017/5/11.
//  Copyright © 2017年 tbox. All rights reserved.
//

#import "TBImageUtil.h"

@implementation TBImageUtil

+(NSString *) image2Base64Str:(UIImage *)image {
    NSData *imageData = nil;
    if ([self imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
    } else {
        imageData = UIImageJPEGRepresentation(image, 1.0f);
    }
    return [imageData base64EncodedStringWithOptions: 0];
}

+ (BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

+(UIImage *) base64Str2Image:(NSString *)str {
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:str options:0];
    
    return [[UIImage alloc]initWithData:imageData];
}

@end
