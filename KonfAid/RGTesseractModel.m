//
//  RGTesseractModel.m
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyright (c) 2013 Ricki Gregersen. All rights reserved.
//

#import "RGTesseractModel.h"
#import "TesseractWrapper.h"

@interface RGTesseractModel()

@property TesseractWrapper *tesseract;

@end

@implementation RGTesseractModel

- (id) init
{
    if (self = [super init]) {
     
        _tesseract = [[TesseractWrapper alloc] initEngineWithLanguage:@"eng"];
        
    }
    
    return self;
}

- (void) OCRImage:(UIImage*) image withHandler:(TesseractHandler) handler
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0);
    
    dispatch_async(queue, ^{
        NSString *result = [_tesseract analyseImage:image];
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(result);
        });
    });
}

@end
