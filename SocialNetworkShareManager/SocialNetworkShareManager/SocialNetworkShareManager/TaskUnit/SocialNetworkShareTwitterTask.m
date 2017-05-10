//
//  SocialNetworkShareTwitterTask.m
//  SocialNetworkShareManager
//
//  Created by wyan assert on 10/05/2017.
//  Copyright © 2017 wyan assert. All rights reserved.
//

#import "SocialNetworkShareTwitterTask.h"
#import "SocialNetworkShareManager.h"
#import <Social/Social.h>

@interface SocialNetworkShareTwitterTask ()

@property (nonatomic, assign) SocialNetworkShareType shareType;

@end

@implementation SocialNetworkShareTwitterTask

- (instancetype)init {
    if(self = [super init]) {
        _shareType = SNSTypeTwitter;
    }
    return self;
}

- (BOOL)willCallbackWhenShareStop {
    return NO;
}

- (void)shareImage:(id)image
           caption:(NSString *)caption
       description:(NSString *)description
              type:(id)shareType
          shareUrl:(NSURL *)shareURL
         albumName:(NSString *)albumName
   andAssociatedVC:(UIViewController *)controller {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        if (composeViewController) {
            [composeViewController addImage:image];
            if(shareURL) {
                [composeViewController addURL:shareURL];
            }
            [composeViewController setInitialText:caption];
            [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
                if (result == SLComposeViewControllerResultDone) {
                    NSLog(@"Posted");
                } else if (result == SLComposeViewControllerResultCancelled) {
                    NSLog(@"Post Cancelled");
                } else {
                    NSLog(@"Post Failed");
                }
            }];
            [controller presentViewController:composeViewController animated:YES completion:nil];
        }
    }
    
}

@end