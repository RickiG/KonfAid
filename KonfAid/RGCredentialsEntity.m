//
//  RGCredentialsEntity.m
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyleft (c) 2013 Ricki Gregersen. No rights reserved.
//

#import "RGCredentialsEntity.h"

@implementation RGCredentialsEntity

- (id) initWithString:(NSString*) string andType:(CredentialType) type
{
    if (self = [super init]) {
        
        _type = type;
        _string = string;
    }
    
    return self;
}
    
@end
