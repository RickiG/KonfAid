//
//  RGTesseractModel.m
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyright (c) 2013 Ricki Gregersen. All rights reserved.
//

#import "RGTesseractModel.h"
#import "Tesseract.h"
#import "TesseractWrapper.h"

@interface RGTesseractModel()

@property Tesseract *tesseract;

@end

@implementation RGTesseractModel

- (id) init
{
    if (self = [super init]) {
     
//        _tesseract = [[Tesseract alloc] initEngineWithLanguage:@"eng"];
        
        _tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
        
        [_tesseract setVariableValue:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ:/@.-" forKey:@"tessedit_char_whitelist"];
    }
    
    return self;
}

- (void) OCRImage:(UIImage*) image withHandler:(TesseractHandler) handler
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0);
    
    dispatch_async(queue, ^{
        
        [_tesseract setImage:image];
        [_tesseract recognize];
        
//        NSString *result = [_tesseract analyseImage:image];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(_tesseract.recognizedText);
//            handler(result);
        });
    });
}

@end
