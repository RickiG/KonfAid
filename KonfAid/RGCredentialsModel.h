//
//  RGCredentialsModel.h
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyleft (c) 2013 Ricki Gregersen. No rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGCredentialsModel : NSObject

@property NSMutableArray *credentials;

- (id) initWithText:(NSString*) string;

@end
