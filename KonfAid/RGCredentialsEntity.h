//
//  RGCredentialsEntity.h
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyleft (c) 2013 Ricki Gregersen. No rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CredentialType) {

    CredentialTypeEmail,
    CredentialTypeURL,
    CredentialTypeTwitter
    
};

@interface RGCredentialsEntity : NSObject

@property CredentialType type;
@property NSString *string;

- (id) initWithString:(NSString*) string andType:(CredentialType) type;

@end
