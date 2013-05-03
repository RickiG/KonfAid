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

@end
