//
//  RGTesseractModel.h
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyleft (c) 2013 Ricki Gregersen. No rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TesseractHandler)(NSString *result);

@interface RGTesseractModel : NSObject

@property(nonatomic, copy) TesseractHandler tesseractHandler;

- (void) OCRImage:(UIImage*) image withHandler:(TesseractHandler) handler;

@end
