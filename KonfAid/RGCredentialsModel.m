//
//  RGCredentialsModel.m
//  KonfAid
//
//  Created by Ricki Gregersen on 5/3/13.
//  Copyleft (c) 2013 Ricki Gregersen. No rights reserved.
//

#import "RGCredentialsModel.h"
#import "RGCredentialsEntity.h"

@interface RGCredentialsModel ()

@property NSDataDetector *detector;

@end

@implementation RGCredentialsModel

- (id) initWithText:(NSString*) string
{
    if (self = [super init]) {
        
        _credentials = [NSMutableArray array];
        _detector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeLink error:nil];
        if (string) {
            [self detectDataInString:string];
        }
    }
    
    return self;
}

- (void) detectDataInString:(NSString*) string
{
    if (!string) return;
    
    NSError *error = nil;
    
    NSRegularExpression *emailPattern = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+"
                                                                                  options:NSRegularExpressionCaseInsensitive error:&error];
    NSRegularExpression *urlPattern = [NSRegularExpression regularExpressionWithPattern:@"(?i)\\b((?:[a-z][\\w-]+:(?:/{1,3}|[a-z0-9%])|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/?)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))*(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’])*)"
                                                                                options:NSRegularExpressionCaseInsensitive
                                                                                  error:&error];
    
    NSRegularExpression *twitterPattern = [NSRegularExpression regularExpressionWithPattern:@"/@([A-Za-z0-9_]{1,15})/"
                                                                                    options:NSRegularExpressionCaseInsensitive error:&error];

    
    NSArray *emailMatches = [emailPattern matchesInString:string
                                      options:0
                                        range:NSMakeRange(0, [string length])];
    
    NSArray *urlMatches = [urlPattern matchesInString:string
                                                  options:0
                                                    range:NSMakeRange(0, [string length])];
    
    NSArray *twitterMatches = [twitterPattern matchesInString:string
                                                  options:0
                                                    range:NSMakeRange(0, [string length])];

    [emailMatches enumerateObjectsUsingBlock:^(NSTextCheckingResult *result, NSUInteger idx, BOOL *stop) {

        NSString *emailStr = [string substringWithRange:[result range]];
        RGCredentialsEntity *entity = [[RGCredentialsEntity alloc] initWithString:emailStr andType:CredentialTypeEmail];
        [_credentials addObject:entity];
    }];

    [twitterMatches enumerateObjectsUsingBlock:^(NSTextCheckingResult *result, NSUInteger idx, BOOL *stop) {

        NSString *twitterStr = [string substringWithRange:[result range]];
        RGCredentialsEntity *entity = [[RGCredentialsEntity alloc] initWithString:twitterStr andType:CredentialTypeTwitter];
        [_credentials addObject:entity];
    }];
    
    [urlMatches enumerateObjectsUsingBlock:^(NSTextCheckingResult *result, NSUInteger idx, BOOL *stop) {
        
        NSString *urlStr = [string substringWithRange:[result range]];
        RGCredentialsEntity *entity = [[RGCredentialsEntity alloc] initWithString:urlStr andType:CredentialTypeURL];
        [_credentials addObject:entity];
    }];
    
    RGCredentialsEntity *entity = [[RGCredentialsEntity alloc] initWithString:@"antimega" andType:CredentialTypeTwitter];
    [_credentials addObject:entity];
    
    [_credentials enumerateObjectsUsingBlock:^(RGCredentialsEntity *cred, NSUInteger idx, BOOL *stop) {
        
        NSLog(@"%@", cred.string);
        
    }];
}

@end
